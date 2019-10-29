#import <UIKit/UIKit.h>

@protocol TQTableViewDataSource , TQTableViewDelegate;

@interface TQMultistageTableView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,assign) id <TQTableViewDataSource> dataSource;

@property (nonatomic,assign) id <TQTableViewDelegate>   delegate;

@property (nonatomic,readonly,strong) NSIndexPath *openedIndexPath;
@property (nonatomic,readonly,strong) UITableView *tableView;
@property (nonatomic,strong)NSString *redirectFrom;
@property (nonatomic,strong) UIView *atomView;

@property (nonatomic) CGPoint atomOrigin;

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

- (id)dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)identifier;

- (void)sendCellTouchActionWithIndexPath:(NSIndexPath *)indexPath;

- (void)sendHeaderTouchActionWithSection:(NSInteger)section;
-(void)closeAllRow:(NSIndexPath*)indexpath;
- (void)reloadData;

- (UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section;
- (UITableViewHeaderFooterView *)footerViewForSection:(NSInteger)section;

- (BOOL)isOpenedSection:(NSInteger)section;

@end

@protocol TQTableViewDataSource <NSObject>

@required

- (NSInteger)mTableView:(TQMultistageTableView *)mTableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)mTableView:(TQMultistageTableView *)mTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)numberOfSectionsInTableView:(TQMultistageTableView *)mTableView;              // Default is 1 if not implemented

@end

@protocol TQTableViewDelegate <NSObject>

@optional
- (void)mscrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForAtomAtIndexPath:(NSIndexPath *)indexPath;

- (UITableViewHeaderFooterView *)mTableView:(TQMultistageTableView *)mTableView viewForHeaderInSection:(NSInteger)section;
- (void)tableViewHeaderTouchUpInside:(UITapGestureRecognizer *)gesture;
- (void)mTableView:(TQMultistageTableView *)mTableView willOpenHeaderAtSection:(NSInteger)section;
- (void)mTableView:(TQMultistageTableView *)mTableView willCloseHeaderAtSection:(NSInteger)section;

- (void)mTableView:(TQMultistageTableView *)mTableView willOpenRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)mTableView:(TQMultistageTableView *)mTableView willCloseRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)mTableView:(TQMultistageTableView *)mTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
