#https://github.com/haml/haml/issues/828
#http://stackoverflow.com/questions/34804880/weird-behavior-on-form-data-signature-with-a-get-request/34805154
require 'haml/template'
Haml::Template.options[:ugly] = true