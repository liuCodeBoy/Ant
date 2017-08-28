//
//  CustomTextField.m
//  TextField自动换行
//
//  Created by yangqijia on 16/8/11.
//  Copyright © 2016年 yangqijia. All rights reserved.
//

#import "CustomTextField.h"
#import <SVProgressHUD/SVProgressHUD.h>
@implementation CustomTextField
{
    //坐标
    CGRect   _frame;
    //用label显示内容
    UILabel  *_label;
    //是否显示清空按钮
    BOOL     _clear;
    //设置leftView
    UIView   *_leftView;
    //设置字号
    CGFloat  _fontSize;
}

//
//-(CGRect)textRectForBounds:(CGRect)bounds{
//    CGRect  inset = CGRectMake(bounds.origin.x + 15 ,  -(bounds.size.height / 2) + 25, bounds.size.width - 30,  bounds.size.height);
//    return inset;
//}
//
//
//
//-(CGRect)placeholderRectForBounds:(CGRect)bounds {
//     CGRect  inset = CGRectMake(bounds.origin.x + 15 ,  -(bounds.size.height / 2) + 25, bounds.size.width - 30,  bounds.size.height);
//    return inset;
//
//}
//
//-(CGRect)editingRectForBounds:(CGRect)bounds{
//    CGRect  inset = CGRectMake(bounds.origin.x + 15 ,  -(bounds.size.height / 2) + 25, bounds.size.width - 30,  bounds.size.height);
//    return inset;
//
//}

/**
 *  自定义初始化方法
 *
 *  @param frame       frame
 *  @param placeholder 提示语
 *  @param clear       是否显示清空按钮 YES为显示
 *  @param view        是否设置leftView不设置传nil
 *  @param font        设置字号
 *
 *  @return
 */

-(id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder clear:(BOOL)clear leftView:(id)view fontSize:(CGFloat)font
{
    self = [super initWithFrame:frame];
    if (self) {
        _frame = frame;
        _clear = clear;
        _leftView = (UIView *)view;
        _fontSize = font;
        self.placeholder = placeholder;
        self.textColor = [UIColor clearColor];
        self.font = [UIFont systemFontOfSize:_fontSize];
        self.delegate = self;
        if (clear) {
            self.clearButtonMode = UITextFieldViewModeAlways;
        }
        if (view) {
            self.leftView = view;
            self.leftViewMode = UITextFieldViewModeAlways;
        }
        [self createLabel];
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

/**
 *  监听textField内容的改变
 *
 *  
 */
- (void) textFieldDidChange:(id) sender {
    UITextField *textField = (UITextField *)sender;
    
    CGSize size = [self labelText:[NSString stringWithFormat:@"%@|",textField.text] fondSize:_fontSize width:_label.frame.size.width];
    _label.frame = CGRectMake(_label.frame.origin.x, _label.frame.origin.y, _label.frame.size.width, size.height < _frame.size.height ? _frame.size.height : size.height);
    self.frame = CGRectMake(_frame.origin.x, _frame.origin.y, _frame.size.width, size.height < _frame.size.height ? _frame.size.height : size.height);
    
    if (textField.text.length == 0) {
        _label.text = @"";
        self.tintColor=[UIColor blueColor];
    }else{
        //添加一个假的光标
        self.tintColor=[UIColor clearColor];
        NSString *text = [NSString stringWithFormat:@"%@|",textField.text];
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:text];
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(text.length - 1, 1)];
        _label.attributedText = attString;
    }

}

/**
 *  创建label
 */
-(void)createLabel
{
    _label = [[UILabel alloc]initWithFrame:CGRectMake(_frame.origin.x + 15,  0 , _frame.size.width - 30, _frame.size.height)];

    if (_leftView) {
        _label.frame = CGRectMake(_leftView.frame.size.width, _label.frame.origin.y, _label.frame.size.width-_leftView.frame.size.width, _label.frame.size.height);
    }
    if (_clear) {
        _label.frame = CGRectMake(_label.frame.origin.x, _label.frame.origin.y, _label.frame.size.width-20, _label.frame.size.height);
    }
    _label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    _label.font = [UIFont systemFontOfSize:_fontSize];
    _label.numberOfLines = 0;
    [self addSubview:_label];
}

#pragma mark - UITextFieldDelegate
//点击return回收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//开始编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
//开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}
//将要编辑完成
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
//编辑完成
- (void)textFieldDidEndEditing:(UITextField *)textField
{
}
//点击键盘调用
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{    //string就是此时输入的那个字符 textField就是此时正在输入的那个输入框 返回YES就是可以改变输入框的值 NO相反
    
    if ([string isEqualToString:@"n"])
        //按回车可以改变 //这里这个字符写什么，就只能输入什么
    {
        return YES;
    }
    
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    //判断是否是我们想要限定的那个输入框
    {
        if ([toBeString length] > 150) { //如果输入框内容大于150则弹出警告
            textField.text = [toBeString substringToIndex: 150];
            [SVProgressHUD showErrorWithStatus:@"你的输入超过最大限额"];
            
            return NO;
        }
    }
    
    return YES;
}
//点击清空按钮
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    _label.text = @"";
    return YES;
}
/**
 *  计算字符串长度，UILabel自适应高度
 *
 *  @param text  需要计算的字符串
 *  @param size  字号大小
 *  @param width 最大宽度
 *
 *  @return 返回大小
 */
-(CGSize)labelText:(NSString *)text fondSize:(float)size width:(CGFloat)width
{
    NSDictionary *send = @{NSFontAttributeName: [UIFont systemFontOfSize:size]};
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(width, 0)
                                         options:NSStringDrawingTruncatesLastVisibleLine |
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                      attributes:send context:nil].size;
    
    return textSize;
}


//string就是此时输入的那个字符 textField就是此时正在输入的那个输入框 返回YES就是可以改变输入框的值 NO相反


/*
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    if string == "\n" //按会车可以改变
    {
        return true
    }
    let   tempString = textField.text as NSString?
    let   toBeString   = (tempString?.replacingCharacters(in: range, with: string)) as NSString?
    //得到输入框的内容
    
    if (self.textField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ((toBeString?.length)! > 100) { //如果输入框内容大于100则弹出警告
            textField.text = toBeString?.substring(to: 100)
            let alter = UIAlertView.init(title: nil, message: "超过最大字数不能输入了", delegate: nil, cancelButtonTitle:"OK")
            alter.show()
            return false
        }
    }
    return true
}
*/
@end
