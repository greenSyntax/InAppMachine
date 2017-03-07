Pod::Spec.new do |s|
  s.name             = 'InAppManager'
  s.version          = '1.0.1'
  s.summary          = 'A Wrapper Class over StoreKit.framework for InApp Purchase operations.'
 
  s.description      = <<-DESC
A Wrapper Class over StoreKit.framework for InApp Purchase operations. You can request InApp Product , then Purchase and log the response transaction data.
                       DESC
 
  s.homepage         = 'https://github.com/greenSyntax/InAppManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Abhishek Kumar Ravi' => 'ab.abhishek.ravi@gmail.com' }
  s.source           = { :git => 'https://github.com/greenSyntax/InAppManager.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '9.0'
  s.source_files = 'InAppManager/Classes/**/*'

  s.pod_target_xcconfig =  {
  'SWIFT_VERSION' => '3.0',
}
 
end