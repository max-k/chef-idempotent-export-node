# export-node

Fork of [export-node](https://supermarket.chef.io/cookbooks/export-node) made to be compatible with force_idempotency kitchen provisionner's configuration.

idempotent-export-node exports node attributes to a json file so that it can be retrieved from a kitchen test.

## Usage

Add the export-node cookbook to the end of the runlist in your kitchen suites:

```yaml
suites:
  - name: my-suite
    run_list:
      - recipe[cookbook-under-test]
      - recipe[idempotent-export-node]
```

Now your tests can access any node attribute by parsing the file's json to a hash:

```ruby
if os.family == 'debian'

    # Get current local path
    current_path = File.dirname(__FILE__)

    # Get chef node informations
    node = json('/tmp/kitchen/chef_node.json')

    # Check templated sources.list
    describe file('/etc/apt/sources.list') do

        # Create a local variable to store codename
        let(:codename) { node['default']['base']['codename'] }

        it { should be_file }
        its('owner') { should eq 'root' }
        its('content') { should eq File.read("#{current_path}/files/#{codename}.list") }
    end
end
```

Windows instances will store the node data in `%TEMP%\kitchen\chef_node.json` and other platforms will store the node data in `/tmp/kitchen/chef_node.json`.
