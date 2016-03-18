//
//  ActionSheetStringDictPicker.m
//  Pods
//
//  Created by vanney on 16/3/15.
//
//

#import "ActionSheetStringDictPicker.h"

@interface ActionSheetStringDictPicker () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *firstRow;
@property (nonatomic, strong) NSDictionary *secondDict;
@property (nonatomic, strong) NSMutableArray *initialIndexs;

@end

@implementation ActionSheetStringDictPicker

- (instancetype)initWithTitle:(NSString *)title firstRow:(NSArray *)firstRow secondDict:(NSDictionary *)secondDict initialIndexs:(NSArray *)indexs doneBlock:(ActionStringDictDoneBlock)doneBlock cancelBlock:(ActionStringDictCancelBlock)cancelBlock origin:(id)origin {
    self = [super initWithTarget:nil successAction:nil cancelAction:nil origin:origin];
    if (self) {
        _firstRow = firstRow;
        _secondDict = secondDict;
        self.initialIndexs = [NSMutableArray arrayWithArray:indexs];
        _onActionSheetDone = doneBlock;
        _onActionSheetCancel = cancelBlock;
        self.title = title;
    }

    return self;
}

+ (instancetype)showPickerWithTitle:(NSString *)title firstRow:(NSArray *)firstRow secondDict:(NSDictionary *)secondDict initialIndexs:(NSArray *)indexs doneBlock:(ActionStringDictDoneBlock)doneBlock cancelBlock:(ActionStringDictCancelBlock)cancelBlock origin:(id)origin {
    ActionSheetStringDictPicker *picker = [[ActionSheetStringDictPicker alloc] initWithTitle:title firstRow:firstRow secondDict:secondDict initialIndexs:indexs doneBlock:doneBlock cancelBlock:cancelBlock origin:origin];
    [picker showActionSheetPicker];
    return picker;
}


#pragma mark - Override Super Method

- (UIView *)configuredPickerView {
    if (!_firstRow || !_secondDict || _firstRow.count <= 0) {
        return nil;
    }

    CGRect pickerFrame = CGRectMake(0, 40, self.viewSize.width, 216);
    UIPickerView *stringDictPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    stringDictPicker.delegate = self;
    stringDictPicker.dataSource = self;

    stringDictPicker.showsSelectionIndicator = YES;
    stringDictPicker.userInteractionEnabled = YES;

    [self performInitialSelectionInPickerView:stringDictPicker];

    self.pickerView = stringDictPicker;
    return stringDictPicker;
}

- (void)notifyTarget:(id)target didSucceedWithAction:(SEL)successAction origin:(id)origin {
    if (_onActionSheetDone) {
        _onActionSheetDone(self, [self selectedIndexs], [self selection]);
        return;
    }
}

- (void)notifyTarget:(id)target didCancelWithAction:(SEL)cancelAction origin:(id)origin {
    if (_onActionSheetCancel) {
        _onActionSheetCancel(self);
        return;
    }
}


#pragma mark - UIPickerView DataSource && Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _firstRow.count;
    } else {
        NSInteger firstLevel = ((NSNumber *)[_initialIndexs firstObject]).integerValue;
        NSString *secondKey = [_firstRow objectAtIndex:firstLevel];
        NSArray *secondRow = [_secondDict objectForKey:secondKey];
        return secondRow.count;
    }
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSInteger firstRow = ((NSNumber *)[_initialIndexs firstObject]).integerValue;
    NSInteger secondRow = ((NSNumber *)[_initialIndexs lastObject]).integerValue;
    id obj = nil;
    if (component == 0) {
        obj = [_firstRow objectAtIndex:row];
    } else {
        NSArray *secondLevel = [_secondDict objectForKey:[_firstRow objectAtIndex:firstRow]];
        obj = [secondLevel objectAtIndex:row];
    }

    if ([obj isKindOfClass:[NSString class]])
        return [[NSAttributedString alloc] initWithString:obj attributes:self.pickerTextAttributes];

    if ([obj respondsToSelector:@selector(description)])
        return [[NSAttributedString alloc] initWithString:[obj performSelector:@selector(description)] attributes:self.pickerTextAttributes];

    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger firstRow = ((NSNumber *)[_initialIndexs firstObject]).integerValue;
    NSInteger secondRow = ((NSNumber *)[_initialIndexs lastObject]).integerValue;
    if (component == 0) {
        if (row != firstRow) {
            [_initialIndexs replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:row]];
            NSArray *secondLevel = [_secondDict objectForKey:[_firstRow objectAtIndex:row]];
            NSInteger curSecondMax = secondLevel.count - 1;
            if (curSecondMax < secondRow) {
                [_initialIndexs replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:curSecondMax]];
            }
            [pickerView reloadComponent:1];
            //[self performInitialSelectionInPickerView:pickerView];
        }
    } else {
        if (row != secondRow) {
            [_initialIndexs replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:row]];
        }
    }
}


#pragma mark - Private Method

- (void)performInitialSelectionInPickerView:(UIPickerView *)pickerView {
    NSInteger firstRow = ((NSNumber *)[_initialIndexs firstObject]).integerValue;
    NSInteger secondRow = ((NSNumber *)[_initialIndexs lastObject]).integerValue;
    [pickerView selectRow:firstRow inComponent:0 animated:NO];
    [pickerView selectRow:secondRow inComponent:1 animated:NO];
}

- (NSArray *)selectedIndexs {
    NSArray *selectedIndexs = [_initialIndexs copy];
    return selectedIndexs;
}

- (NSArray *)selection {
    NSInteger firstRow = ((NSNumber *)[_initialIndexs firstObject]).integerValue;
    NSInteger secondRow = ((NSNumber *)[_initialIndexs lastObject]).integerValue;

    NSMutableArray *selections = [NSMutableArray array];
    [selections addObject:[_firstRow objectAtIndex:firstRow]];
    NSArray *secondLevel = [_secondDict objectForKey:[_firstRow objectAtIndex:firstRow]];
    [selections addObject:[secondLevel objectAtIndex:secondRow]];

    return selections;
}


@end
