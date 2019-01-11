describe file('/tmp/kitchen/chef_node.json') do
    its('type') { should eq :file }
    its('content') { should match (/"recipe\[idempotent-export-node\]"/) }
    its('content') { should_not match (/"counters"/) }
    its('content') { should_not match (/"percent_used"/) }
end
