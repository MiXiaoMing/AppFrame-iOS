Pod::Spec.new do |s|
  s.name             = 'AppFrame'
  s.version          = '1.1.0'
  s.summary          = 'AppFrame'
  s.homepage         = 'https://github.com/MiXiaoMing'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'edz' => 'AppFrame' }
  s.source           = { :git => 'https://github.com/MiXiaoMing/AppFrame-iOS.git', :tag => s.version.to_s }
  s.requires_arc = true

  s.ios.deployment_target = '8.0'
  
  s.source_files = 'AppFrame/AppFrame.h'
  s.public_header_files = 'AppFrame/AppFrame.h'

  s.subspec 'Utils' do |ss|
    ss.source_files = 'AppFrame/Utils/*.h'
    ss.public_header_files = 'AppFrame/Utils/*.h'
    
    ss.subspec 'Marco' do |sss|
      sss.source_files = 'AppFrame/Utils/Marco/*.h'
      sss.public_header_files = 'AppFrame/Utils/Marco/*.h'
    end

    ss.subspec 'Category' do |sss|

      sss.subspec 'Foundation' do |ssss|

        ssss.subspec 'NSBundle' do |sssss|
          sssss.source_files = 'AppFrame/Utils/Category/Foundation/NSBundle/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/Foundation/NSBundle/*.h'
        end

        ssss.subspec 'NSNumber' do |sssss|
          sssss.source_files = 'AppFrame/Utils/Category/Foundation/NSNumber/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/Foundation/NSNumber/*.h'
        end

        ssss.subspec 'NSArray' do |sssss|
          sssss.dependency 'AppFrame/Utils/Category/Foundation/NSObject' 
          sssss.source_files = 'AppFrame/Utils/Category/Foundation/NSArray/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/Foundation/NSArray/*.h'
        end

        ssss.subspec 'NSDate' do |sssss|
          sssss.source_files = 'AppFrame/Utils/Category/Foundation/NSDate/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/Foundation/NSDate/*.h'
        end

        ssss.subspec 'NSDictionary' do |sssss|
          sssss.source_files = 'AppFrame/Utils/Category/Foundation/NSDictionary/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/Foundation/NSDictionary/*.h'
        end

        ssss.subspec 'NSError' do |sssss|
          sssss.source_files = 'AppFrame/Utils/Category/Foundation/NSError/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/Foundation/NSError/*.h'
        end

        ssss.subspec 'NSFileManager' do |sssss|
          sssss.source_files = 'AppFrame/Utils/Category/Foundation/NSFileManager/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/Foundation/NSFileManager/*.h'
        end

        ssss.subspec 'NSObject' do |sssss|
          sssss.source_files = 'AppFrame/Utils/Category/Foundation/NSObject/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/Foundation/NSObject/*.h'
        end

        ssss.subspec 'NSSet' do |sssss|
          sssss.source_files = 'AppFrame/Utils/Category/Foundation/NSSet/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/Foundation/NSSet/*.h'
        end

        ssss.subspec 'NSString' do |sssss|
          sssss.dependency 'AppFrame/Utils/Category/Foundation/NSObject' 
          sssss.source_files = 'AppFrame/Utils/Category/Foundation/NSString/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/Foundation/NSString/*.h'
        end

        ssss.subspec 'NSTimer' do |sssss|
          sssss.source_files = 'AppFrame/Utils/Category/Foundation/NSTimer/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/Foundation/NSTimer/*.h'
        end

      end

      sss.subspec 'UIKit' do |ssss|
        ssss.subspec 'UIWindow' do |sssss|
          sssss.source_files = 'AppFrame/Utils/Category/UIKit/UIWindow/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/UIKit/UIWindow/*.h'
        end
        ssss.subspec 'UIColor' do |sssss|
          sssss.source_files = 'AppFrame/Utils/Category/UIKit/UIColor/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/UIKit/UIColor/*.h'
        end

        ssss.subspec 'UIButton' do |sssss|
          sssss.dependency 'AppFrame/Utils/Category/UIKit/UIImage'
          sssss.source_files = 'AppFrame/Utils/Category/UIKit/UIButton/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/UIKit/UIButton/*.h'
        end

        ssss.subspec 'UIDevice' do |sssss|
          sssss.source_files = 'AppFrame/Utils/Category/UIKit/UIDevice/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/UIKit/UIDevice/*.h'
        end

        ssss.subspec 'UIImage' do |sssss|
          sssss.source_files = 'AppFrame/Utils/Category/UIKit/UIImage/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/UIKit/UIImage/*.h'
        end

        ssss.subspec 'UILabel' do |sssss|
          sssss.source_files = 'AppFrame/Utils/Category/UIKit/UILabel/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/UIKit/UILabel/*.h'
        end

        ssss.subspec 'UINavigation' do |sssss|
          sssss.dependency 'AppFrame/Utils/Category/Foundation/NSObject' 
          sssss.source_files = 'AppFrame/Utils/Category/UIKit/UINavigation/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/UIKit/UINavigation/*.h'
        end

        ssss.subspec 'UIView' do |sssss|
          sssss.source_files = 'AppFrame/Utils/Category/UIKit/UIView/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/UIKit/UIView/*.h'
        end
        
        ssss.subspec 'UIScrollView' do |sssss|
          sssss.source_files = 'AppFrame/Utils/Category/UIKit/UIScrollView/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/UIKit/UIScrollView/*.h'
        end

        ssss.subspec 'UIViewController' do |sssss|
          sssss.source_files = 'AppFrame/Utils/Category/UIKit/UIViewController/*.{h,m}'
          sssss.public_header_files = 'AppFrame/Utils/Category/UIKit/UIViewController/*.h'
        end

      end

      sss.subspec 'CoreLocation' do |ssss|
        ssss.source_files = 'AppFrame/Utils/Category/CoreLocation/*.{h,m}'
        ssss.public_header_files = 'AppFrame/Utils/Category/CoreLocation/*.h'
      end

    end

  end

  s.subspec 'Library' do |ss|

    ss.source_files = 'AppFrame/Library/*.h'
    ss.public_header_files = 'AppFrame/Library/*.h'

    ss.subspec 'Network' do |sss|

      sss.subspec 'Http' do |ssss|
        ssss.dependency 'AppFrame/Framework/Base/Model'
        ssss.source_files = 'AppFrame/Library/Network/Http/*.{h,m}'
        ssss.public_header_files = 'AppFrame/Library/Network/Http/*.h'
      end

    end

    ss.subspec 'Storage' do |sss|

      sss.subspec 'Keychain' do |ssss|
        ssss.source_files = 'AppFrame/Library/Storage/Keychain/*.{h,m}'
        ssss.public_header_files = 'AppFrame/Library/Storage/Keychain/*.h'
      end

    end

  end

  s.subspec 'Framework' do |ss|

    ss.source_files = 'AppFrame/Framework/*.h'
    ss.public_header_files = 'AppFrame/Framework/*.h'

    ss.subspec 'Base' do |sss|

      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'AppFrame/Framework/Base/Model/*.{h,m}'
        ssss.public_header_files = 'AppFrame/Framework/Base/Model/*.h'
      end
      sss.subspec 'View' do |ssss|
        ssss.dependency 'AppFrame/Utils' 
        ssss.source_files = 'AppFrame/Framework/Base/View/*.{h,m}'
        ssss.public_header_files = 'AppFrame/Framework/Base/View/*.h'
      end

    end

    ss.subspec 'General' do |sss|

      sss.subspec 'QMLoading' do |ssss|
        ssss.dependency 'MBProgressHUD', '~> 1.1.0'
        ssss.source_files = 'AppFrame/Framework/General/QMLoading/*.{h,m}'
        ssss.public_header_files = 'AppFrame/Framework/General/QMLoading/*.h'
      end
      sss.subspec 'QMCountDownButton' do |ssss|
        ssss.dependency 'AppFrame/Framework/Base'
        ssss.source_files = 'AppFrame/Framework/General/QMCountDownButton/*.{h,m}'
        ssss.public_header_files = 'AppFrame/Framework/General/QMCountDownButton/*.h'
      end
      sss.subspec 'QMAdjustableLabel' do |ssss|
        ssss.dependency 'AppFrame/Framework/Base'
        ssss.source_files = 'AppFrame/Framework/General/QMAdjustableLabel/*.{h,m}'
        ssss.public_header_files = 'AppFrame/Framework/General/QMAdjustableLabel/*.h'
      end
    end

  end
    
  s.resource_bundles = {
    'AppFrame' => ['AppFrame/Resource/*']
  }

  s.frameworks = 'UIKit','Foundation','CoreGraphics'
  s.dependency 'AFNetworking', '~> 3.2.1'
  s.dependency 'MBProgressHUD', '~> 0.9.0'
  s.dependency 'DZNEmptyDataSet', '~> 1.8.1'
  s.dependency 'MJRefresh', '~> 3.1.0'
  s.dependency 'SDWebImage', '~> 3.7.0'
end
