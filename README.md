# AppFrame

使用流程：
1. 克隆远程仓库到本地，添加本地仓库：

    1.1 git clone  http://192.168.1.40/mobile/podRepo.git

    1.2 pod add podRepo http://192.168.1.40/mobile/podRepo.git

2. 更新AppFrame

    2.1 修改代码、podspec内容及版本号

    2.2 检测是否正确：pod lib lint --verbose --allow-warnings --sources='https://github.com/CocoaPods/Specs'

    2.3 提交文件，打tag（必须和podspec版本号一致)

3. 将podspec提交到远程仓库：

    3.1 pod repo push podRepo AppFrame.podspec --allow-warnings  --sources='https://github.com/CocoaPods/Specs'

4. 使用工程更新：pod update
	

