# DSTouchView
==========================================================
一个功能上类似于Slider的控件, 不过更加美观, 操作更加方便.
----------------------------------------------------------
### 使用
        直接把DSTouchView文件夹拉到项目中即可使用
        
### 设置
        可以设置最小值(默认为0),最大值(默认为100),初始值(默认为50).
        可以设置当前值是否可循环,即值减小到最小时再减1会变到最大值,相反亦然,可参照示例程序.
        可以设置是否可以滑动.
        可以设置代理,监听touch的开始,滑动,滑动结束事件.
        可以设置target监听值改变事件.
        
### 示例代码
        DSTouchView *touchView = [[DSTouchView alloc] initWithFrame:CGRectMake(35,  300, 70, 120)];
        touchView.maxValue = 50.0f;
        touchView.minValue = 0.0f;
        touchView.initialValue = 25.0f;
        touchView.isValueCanCirculate = YES;
        [touchView addTarget:self action:@selector(touchViewValueChanged) forControlEvents:UIControlEventValueChanged];
        touchView.delegate = self;
        [self.view addSubview:touchView];


