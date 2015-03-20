#!/usr/bin/ruby
require 'json'

# recursively walk tree to find all containers
# return an array of names followed by [id]
def get_containers tree
    containers = []
    # try to return only useful containers
    if (tree['nodes']+tree['floating_nodes']).empty? && tree['type'] == 2 &&
        !(tree['name'] =~ /^i3bar for output/)
        #print tree.inspect
        #print "\n\n\n"
        containers << tree['name'] + " [#{tree['id']}]"
    end
    (tree['nodes'] + tree['floating_nodes']).each do |node|
        containers += get_containers(node)
    end
    containers
end

IO.popen(['dmenu', '-i', '-p', 'window jump'], 'r+') do |dmenu|
    containers = get_containers(JSON.load(`i3-msg -t get_tree`))
    print containers.inspect
    dmenu.puts(containers)
    dmenu.close_write
    # application switcher? - i3 FAQ - Mozilla Firefox [9130832]
    id = /(\[)([0-9]+)(\])/.match(dmenu.read)[2]
    # print "i3-msg [con_id=#{id}] focus"
    exec "i3-msg [con_id=#{id}] focus"
end
