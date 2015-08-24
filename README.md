# BackgroundTask




### swift实现iOS应用在进入到后台之后，依旧可以执行任务，并不受时间的限制


思路：

	1.使用UIApplication对象的beginBackgroundTaskWithExpirationHandler申请后台执行任务，该任务只有大概3分钟的运行时间

	2.应用申请到后台执行任务后，使用NSTimer开启一个定时任务，主要负责监控应用剩余的后台可执行时间，当可用的时间少于一个值时，播放一段默声音乐，然后调用UIApplication对象的endBackgroundTask方法将之前申请的后台执行任务结束掉，最后再重新申请一个后台执行任务，这样就可以实现后台不限时执行任务了
	
	3.应用在后台播放音乐，需要开启Background Modes，然后勾选Audio and AirPlay即可
	
	注：应用在后台运行的过程中重新申请后台执行任务是无效的，通过在网上查找资料，播放音乐可以让应用进入到一个假前台的状态，此时重新申请后台执行任务是有效的，如此循环n次，就可以获得大约3n的后台执行时间，从而达到后台无限时执行任务
	
