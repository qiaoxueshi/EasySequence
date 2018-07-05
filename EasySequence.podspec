#
# Be sure to run `pod lib lint EasySequence.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EasySequence'
  s.version          = '1.0.0'
  s.summary          = 'a powerful fundamental library to process sequcence type.'

  s.description      = <<-DESC
EasySequence is a powerful fundamental library to process sequcence type, such as array, set, dictionary. All type object which conforms to NSFastEnumeration protocol can be initialzed to an EZSequence instance, then you can operation with them. Finally, you can transfer them back to the original type.
DESC

  s.homepage         = 'https://github.com/meituan/EasySequence'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'William Zang' => 'chengwei.zang.1985@gmail.com', '姜沂' => 'nero_jy@qq.com', 'Qin Hong' => 'qinhong@face2d.com'}
  s.source           = { :git => 'https://github.com/meituan/EasySequence.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
#  s.osx.deployment_target = '10.8'
#  s.watchos.deployment_target = '2.0'
#  s.tvos.deployment_target = '9.0'

  s.module_map = 'EasySequence/EasySequence.modulemap'
  s.module_name = 'EasySequence'

  s.source_files = 'EasySequence/Classes/**/*'

  s.public_header_files = 'EasySequence/Classes/**/*.h'
  s.private_header_files = 'EasySequence/Classes/Private/*.h'
end
