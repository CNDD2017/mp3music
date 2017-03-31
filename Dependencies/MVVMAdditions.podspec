Pod::Spec.new do |s|
  s.name         = "MVVMAdditions"
  s.version      = "1.0"
  s.summary      = "MVVMAdditions framework in Swift"
  s.description  = <<-DESC
                   Lightweight service framework to build MVVM Architecture
                   DESC
  s.homepage     = "https://github.com/TVGSoft"
  s.license      = { :type => "MIT"}
  s.platform     = :ios, "9.0"
  s.authors      = { 'Giap Tran' => 'tvgsoft@gmail.com' }
  s.source       = { :git => "https://github.com/TVGSoft/MVVMAdditions.git", :tag => s.version.to_s }
  s.source_files = "MVVMAdditions/MVVMAdditions/**/*.{h,m,swift}"
  s.public_header_files = "MVVMAdditions/MVVMAdditions/**/*.h"
  s.requires_arc = true
  s.dependency 'Alamofire'
  s.dependency 'SwiftyJSON'
  s.dependency 'KeychainSwift'
  s.dependency 'EventBusSwift'
  s.dependency 'RxSwift'
end
