//
//  ActionSheetStringDictPicker.h
//  Pods
//
//  Created by vanney on 16/3/15.
//
//

#import "AbstractActionSheetPicker.h"

@class ActionSheetStringDictPicker;

typedef void (^ActionStringDictDoneBlock)(ActionSheetStringDictPicker *picker, NSArray *selectedIndexs, id selectedValues);
typedef void (^ActionStringDictCancelBlock)(ActionSheetStringDictPicker *picker);

@interface ActionSheetStringDictPicker : AbstractActionSheetPicker

@property (nonatomic, copy) ActionStringDictDoneBlock onActionSheetDone;
@property (nonatomic, copy) ActionStringDictCancelBlock onActionSheetCancel;

- (instancetype)initWithTitle:(NSString *)title firstRow:(NSArray *)firstRow secondDict:(NSDictionary *)secondDict initialIndexs:(NSArray *)indexs doneBlock:(ActionStringDictDoneBlock)doneBlock cancelBlock:(ActionStringDictCancelBlock)cancelBlock origin:(id)origin;

+ (instancetype)showPickerWithTitle:(NSString *)title firstRow:(NSArray *)firstRow secondDict:(NSDictionary *)secondDict initialIndexs:(NSArray *)indexs doneBlock:(ActionStringDictDoneBlock)doneBlock cancelBlock:(ActionStringDictCancelBlock)cancelBlock origin:(id)origin;

@end
