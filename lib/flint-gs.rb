# encoding: UTF-8

lib = File.expand_path "../../lib/", __FILE__
$:.unshift lib unless $:.include? lib

# FIXME: Fixes an issue with Rails integration due to the gem being named
#        `flint-gs`, but the lib being named `flint` (issue #37)
require "flint"
