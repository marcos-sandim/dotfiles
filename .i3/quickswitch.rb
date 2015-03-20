#!/usr/bin/env ruby
# encoding: utf-8


# https://github.com/badboy/quickswitch-for-i3

require 'i3-ipc'
require 'open3'

DMENU_COMMAND = 'dmenu -l 7 -i -b'
def dmenu input=nil, com = DMENU_COMMAND
  Open3.popen2(com) { |stdin,stdout,wait_thr|
    stdin.write input*"\n" unless input.nil?
    stdin.close
    stdout.read.chomp
  }
end

def filter_leaves tree
  prop = 'nodes'
  tree[prop].map { |node|
    if node[prop].empty?
      node
    else
      filter_leaves node
    end
  }.flatten
end

def main
  i3 = I3::IPC.new
  tree = i3.get_tree

  windows = filter_leaves tree

  names = windows.reject{|win|
    # Not a X window or the i3 bar.
    win['window'].nil? || win['name'] =~ /^i3bar for output/
  }.map do |win|
    [ win['name'], win['window'] ]
  end

  lookup = Hash[names]
  target = dmenu(lookup.keys)

  id = lookup[target]

  i3.command "[id=#{id}] focus"
end

main if __FILE__ == $0
