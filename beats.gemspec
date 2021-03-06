# -*- encoding: utf-8 -*-
require File.expand_path("../lib/beats/version", __FILE__)

Gem::Specification.new do |s|
  s.name         = "beats"
  s.version      = Beats::VERSION
  s.summary      = "A command-line drum machine. Feed it a song notated in YAML, and it will produce a precision-milled Wave file of impeccable timing and feel."
  s.homepage     = "http://beatsdrummachine.com/"
  s.email        = ""
  s.author       = "Joel Strait"
  
  s.files        = %w(README.md Rakefile LICENSE)
  s.files       += Dir["{bin,lib,test}/**/*"] & `git ls-files -z`.split(" ")
  s.test_files   = Dir["test/**/*"]
  
  s.executables  = ["beats"]
  s.require_path = 'lib'
  
  s.description  = <<-EOD
    A command-line drum machine. Feed it a song notated in YAML, and it 
    will produce a precision-milled Wave file of impeccable timing and feel.
  EOD
  
  s.add_dependency 'wavefile', '~> 0.3.0'
  
end
  
