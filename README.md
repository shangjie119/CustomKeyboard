# CustomKeyboard
很多项目中都使用自定义键盘，实现自定义键盘有很多方法，本文讲的是修改UITextField/UITextView的inputView来实现自定义键盘。  
如何修改已经知道了，但是怎么修改。有两种思路：
1. 自定义CustomTextField/CustomTextView,直接实现如下代码

```
textField.inputView = customView;	
textView.inputView = customView;  
```
但是这样写有个弊端，就是通用性不强。比如项目中可能要实现某个具体业务逻辑，这个textField/textView是继承ATextField/ATextView，其他地方又有用到的是继承BTextField/BTextView，那我们再写代码时候，可能需要写n个自定义textField/textView，用起来就非常麻烦了，所以这种方法不推荐。  
2. 使用分类来实现自定义键盘  
思路就是在分类中增加一个枚举，这个枚举定义了不同类型的键盘  

```
typedef NS_ENUM(NSUInteger, SJKeyboardType)
{
   SJKeyboardTypeDefault,  // 使用默认键盘
   SJKeyboardTypeNumber    // 使用自定义数字键盘
   // 还可以根据需求 自定义其他样式...
}; 
```
写一个属性，来标记键盘类型  

`@property (nonatomic, assign) SJKeyboardType sjKeyboardType; ` 
在.m文件中实现getter和setter方法

```
static NSString *sjKeyboardTypeKey = @"sjKeyboardTypeKey";
- (SJKeyboardType)sjKeyboardType  
{  
	return [objc_getAssociatedObject(self, &sjKeyboardTypeKey) integerValue];  
}  

- (void)setSjKeyboardType:(SJKeyboardType)sjKeyboardType
{
    objc_setAssociatedObject(self, &sjKeyboardTypeKey, @(sjKeyboardType), OBJC_ASSOCIATION_ASSIGN);
    [self setupKeyboard:sjKeyboardType];
}
```
在set方法中来实现自定义键盘视图设置及对应点击方法实现
	
```
- (void)setupKeyboard:(SJKeyboardType)sjKeyboardType
{
    
    switch (sjKeyboardType) {
        case SJKeyboardTypeDefault:
            break;
        case SJKeyboardTypeNumber: {
            SJCustomKeyboardView *numberInputView = [[[NSBundle mainBundle] loadNibNamed:@"SJCustomKeyboardView" owner:self options:nil] lastObject];
            numberInputView.frame = CGRectMake(0, 0, SJSCREEN_WIDTH, SJNumberKeyboardHeight + SJCustomKeyboardBottomMargin);
            self.inputView = numberInputView;
            numberInputView.textFieldReplacementString = ^(NSString * _Nonnull string) {
                BOOL canEditor = YES;
                if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
                    canEditor = [self.delegate textField:self shouldChangeCharactersInRange:NSMakeRange(self.text.length, 0) replacementString:string];
                }
                
                if (canEditor) {
                    [self replaceRange:self.selectedTextRange withText:string];
                }
            };
            numberInputView.textFieldShouldDelete = ^{
                BOOL canEditor = YES;
                if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)] && self.text.length) {
                    canEditor = [self.delegate textField:self shouldChangeCharactersInRange:NSMakeRange(self.text.length - 1, 1) replacementString:@""];
                }
                if (canEditor) {
	                   [self deleteBackward];
                }
            };
            numberInputView.textFieldShouldClear = ^{
                BOOL canClear = YES;
                if ([self.delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
                    canClear = [self.delegate textFieldShouldClear:self];
                }
                if (canClear) {
                    [self setText:@""];
                }
            };
            numberInputView.textFieldShouldReturn = ^{
                if ([self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
                    [self.delegate textFieldShouldReturn:self];
                }
            };
            break;
        }
    }
}
```
之后就需要实现自定义键盘视图，这里需要注意一点，就是如果使用新建子类实现自定义键盘，个人感觉按钮响应用代理实现会看起来逻辑更清晰

```
/*
 用代理看的更清楚 但是分类不能实现代理 所以只能用block实现回调 如果自定义textField可以用代理
 
 @protocol SJCustomKeyboardViewDelegate <NSObject>
 
 - (void)textFieldReplacementString:(NSString *_Nullable)string;
 - (BOOL)textFieldShouldDelete;
 - (BOOL)textFieldShouldClear;
 - (BOOL)textFieldShouldReturn;
 
 @end
 */
 ```
但是分类不能实现代理，所以只能用block来实现回调

```
@property (nonatomic, copy) void (^textFieldReplacementString)(NSString *string);
@property (nonatomic, copy) void (^textFieldShouldDelete)(void);
@property (nonatomic, copy) void (^textFieldShouldClear)(void);
@property (nonatomic, copy) void (^textFieldShouldReturn)(void);
```
.m中只需要实现按钮的点击方法和对应的回调方法即可。  
这样好处是只需要引入头文件，修改一个属性即可实现自定义键盘，不会影响项目中其他的业务逻辑。

```
self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, SJSCREEN_WIDTH - 40, 40)];  
self.textField.placeholder = @"input";
self.textField.borderStyle = UITextBorderStyleBezel;
self.textField.delegate = self;
[self.view addSubview:self.textField];
    
self.textField.sjKeyboardType = SJKeyboardTypeNumber;
```
