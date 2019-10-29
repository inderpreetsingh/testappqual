#import "TQMultistageTableView.h"
#import "ResourceContainerView.h"
#import "CellMatchesContainer.h"
#import "MatchDetailView.h"
#import "CellEquipmentListHeader.h"
#import "CellMatchedLoadListForEquipment.h"
#import "CellAlertDetails.h"
#import "CellCalenderSchedule.h"
#import "HomeVC.h"
typedef enum
{
	TQHeaderLineTouch,
	TQCellLineTouch,
	TQCodeSendTouch,
} TQLineTouchType;

static const CGFloat kDefultHeightForRow    = 44.0f;
static const CGFloat kDefultHeightForAtom   = 44.0f;

@interface TQMultistageTableView ()
{
    UIView *vwfooter;
    UIActivityIndicatorView *activityIndicator;
}
@end
@implementation TQMultistageTableView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _openedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:-1];
        
        _atomOrigin = CGPointMake(0, 0);
        
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.delegate         = self;
        _tableView.dataSource       = self;
        _tableView.backgroundColor  = [UIColor clearColor];
        _tableView.separatorStyle   = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor whiteColor];
        _tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
      
       vwfooter=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
       activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.alpha = 1.0;
        activityIndicator.hidesWhenStopped = YES;
        activityIndicator.color=[UIColor orangeColor];
        [activityIndicator startAnimating];
        
        activityIndicator.frame=CGRectMake(0, 5, SCREEN_WIDTH, 25);
//        CGRect frame=activityIndicator.frame;
//        frame.origin.x=vwfooter.center.x;
       // activityIndicator.frame=frame;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, activityIndicator.frame.size.height, SCREEN_WIDTH, 25)];
        label.textColor = [UIColor lightGrayColor];
        label.text = @"Loading";
        label.font=[UIFont systemFontOfSize:10.0f];
        label.textAlignment=NSTextAlignmentCenter;
         [vwfooter addSubview:activityIndicator];  
         [vwfooter addSubview:label];  
        vwfooter.backgroundColor=[UIColor clearColor];
        vwfooter.alpha=0;
        _tableView.tableFooterView=vwfooter;
        [self addSubview:_tableView];
    }
    return self;
}
#pragma mark - Public Methods
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    id cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    return cell;
}
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath
{
    
    id cell = [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
}
- (id)dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)identifier
{
    return [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}
- (void)sendHeaderTouchActionWithSection:(NSInteger)section
{
    [self openOrCloseHeaderWithSection:section];
}
-(void)closeAllRow:(NSIndexPath*)indexpath
{
    @try {
        NSMutableArray *reloadIndexPaths = [NSMutableArray array];
        reloadIndexPaths = [self buildWillCloseRowsWithRow:indexpath.row];
        [self.tableView reloadRowsAtIndexPaths:reloadIndexPaths withRowAnimation:UITableViewRowAnimationNone];
    } @catch (NSException *exception) {
        
    } 
    
}
- (void)sendCellTouchActionWithIndexPath:(NSIndexPath *)indexPath
{
    [self openOrCloseCellWithTouchType:TQCodeSendTouch forIndexPath:indexPath];
}
- (void)reloadData
{
    _openedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:-1];
    vwfooter.alpha=1;
    [self.tableView reloadData];
}
- (UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section
{
    return [self.tableView headerViewForSection:section];
}
- (UITableViewHeaderFooterView *)footerViewForSection:(NSInteger)section
{
    return [self.tableView footerViewForSection:section];
}
- (BOOL)isOpenedSection:(NSInteger)section
{
    NSIndexPath *indexPath = self.openedIndexPath;
    if (indexPath) {
        return indexPath.section == section;
    }
    return NO;
}
#pragma mark - Private Methods
- (void)addTapGestureRecognizerForView:(UIView *)view action:(SEL)action
{
    if (view)
    {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewCellTouchUpInside:)];
        [view addGestureRecognizer:tapGesture];
    }
}
- (void)removeTapGestureRecognizerFromView:(UIView *)view
{
    if (view)
    {
        for (UIGestureRecognizer *gesture in view.gestureRecognizers)
        {
            if ([gesture.view isEqual:view])
            {
                [view removeGestureRecognizer:gesture];
            }
        }
    }
}
#pragma mark - Private Operation For Header Open & Close

- (NSMutableArray *)buildInsertRowWithSection:(NSInteger)section
{
    NSInteger insert = [self invoke_numberOfRowsInSection:section];
    
    if (insert != 0)
    {
        [self invoke_willOpenHeaderAtSection:section];
    }
    
    _openedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:section];
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < insert; i++)
    {
        [indexPaths addObject: [NSIndexPath indexPathForRow:i inSection:section]];
    }
    
    return indexPaths;
}
- (NSMutableArray *)buildDeleteRowWithSection:(NSInteger)section
{
    NSInteger delete = [self invoke_numberOfRowsInSection:section];;
    
    if (delete != 0)
    {
        [self invoke_willCloseHeaderAtSection:section];
    }
    
    if (section == self.openedIndexPath.section)
    {
        _openedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:-1];
    }
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < delete; i++)
    {
        [indexPaths addObject: [NSIndexPath indexPathForRow:i inSection:section]];
    }
    
    return indexPaths;
}
- (void)openOrCloseHeaderWithSection:(NSInteger)section
{
    @try 
    {
    NSMutableArray *deleteIndexPaths = [[NSMutableArray alloc] init];
    NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
    
    NSInteger oldSection = self.openedIndexPath.section;
    NSInteger newSection = section;
    
    if (oldSection <= -1)
    {
        if (oldSection != newSection)
        {
            insertIndexPaths = [self buildInsertRowWithSection:newSection];
        }
    }
    else
    {
        if (oldSection != newSection && newSection > -1)
        {
            deleteIndexPaths = [self buildDeleteRowWithSection:oldSection];
            insertIndexPaths = [self buildInsertRowWithSection:newSection];
        }
        else
        {
            deleteIndexPaths = [self buildDeleteRowWithSection:oldSection];
        }
    }
    [self.tableView beginUpdates];
    if ([insertIndexPaths count] > 0)
    {
        [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationNone];
    }
    if ([deleteIndexPaths count] > 0)
    {
        [self.tableView deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationNone];
    }
    [self.tableView endUpdates];
    if ([insertIndexPaths count] > 0)
    {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:newSection]
                              atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
    } @catch (NSException *exception) {
        
    } 
}
#pragma mark - Private Operation For Row Open & Close
- (NSMutableArray *)buildWillOpenRowsWithRow:(NSInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:self.openedIndexPath.section];
    
    [self invoke_willOpenRowAtIndexPath:indexPath];
    
    _openedIndexPath = indexPath;
    
    return [NSMutableArray arrayWithObject:indexPath];
}
- (NSMutableArray *)buildWillCloseRowsWithRow:(NSInteger)row
{
    [self.atomView removeFromSuperview];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:self.openedIndexPath.section];
    
    [self invoke_willCloseRowAtIndexPath:indexPath];
    
    if (row == self.openedIndexPath.row)
    {
        _openedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:self.openedIndexPath.section];;
    }
    
    return [NSMutableArray arrayWithObject:indexPath];
}
- (void)openOrCloseCellWithRow:(NSInteger)row
{
    @try {
        NSMutableArray *reloadIndexPaths = [NSMutableArray array];
        NSInteger oldRow = self.openedIndexPath.row;
        NSInteger newRow = row;
        
        if (oldRow <= -1)
        {
            
            if (oldRow != newRow)
            {
                reloadIndexPaths = [self buildWillOpenRowsWithRow:newRow];
            }
        }
        else
        {
            if (oldRow != newRow)
            {
                [reloadIndexPaths addObjectsFromArray: [self buildWillCloseRowsWithRow:oldRow]];
                [reloadIndexPaths addObjectsFromArray: [self buildWillOpenRowsWithRow:newRow]];
            }
            else
            {
                reloadIndexPaths = [self buildWillCloseRowsWithRow:oldRow];
            }
        }
        
        [self.tableView reloadRowsAtIndexPaths:reloadIndexPaths withRowAnimation:UITableViewRowAnimationNone];
    }
    @catch (NSException *exception) 
    {
        NSLog(@"Excepition :%@",exception.description);
        HomeVC *objHomeVC =initVCToRedirect(SBAFTERSIGNUP, HOMEVC);
        AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:objHomeVC];
        [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
    } 
    
}
#pragma mark - Private Operation For Row & Header
- (void)openOrCloseCellWithTouchType:(TQLineTouchType)touchType forIndexPath:(NSIndexPath *)indexPath
{
    switch (touchType)
    {
        case TQHeaderLineTouch:
        {
            [self openOrCloseHeaderWithSection:indexPath.section];
        }
            break;
        case TQCellLineTouch:
        {
                [self openOrCloseCellWithRow:indexPath.row];
        }
            break;
        case TQCodeSendTouch:
        {
            if (indexPath.section != self.openedIndexPath.section)
            {
                [self openOrCloseHeaderWithSection:indexPath.section];
                
                double delayInSeconds = 0.4;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    
                    [self openOrCloseCellWithRow:indexPath.row];
                });
            }
            else
            {
                [self openOrCloseCellWithRow:indexPath.row];
            }
        }
            break;
        default:
            
            break;
    }
}
#pragma mark - Touch Selector
- (void)tableViewHeaderTouchUpInside:(UITapGestureRecognizer *)gesture
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewHeaderTouchUpInside:)])
    {
        [self.delegate tableViewHeaderTouchUpInside:gesture];
    }
    else
    {
        NSInteger section = gesture.view.tag;
    
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:-1 inSection:section];
    
        [self openOrCloseCellWithTouchType:TQHeaderLineTouch forIndexPath:indexPath];
    }
}
- (void)tableViewCellTouchUpInside:(UITapGestureRecognizer *)gesture
{
    @try 
    {
        if([_redirectFrom isEqualToString:@"ALL_EQUIPMENTS"])
        {
            CellMatchedLoadListForEquipment *cell = (CellMatchedLoadListForEquipment *)gesture.view;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            
            CGFloat h = [self invoke_heightForRowAtIndexPath:indexPath];
            CGFloat w = cell.bounds.size.width;
            CGRect rect = CGRectMake(0, 0, w, h);
            CGPoint point = [gesture locationInView:cell];
            if(CGRectContainsPoint(rect,point))
            {
                [self invoke_didSelectRowAtIndexPath:indexPath];
                if (self.atomView)
                {
                    [self openOrCloseCellWithTouchType:TQCellLineTouch forIndexPath:indexPath];
                }
            }
        }
        else if([_redirectFrom isEqualToString:@"ALL_EQUIPMENTS_ALTERNATE"])
        {
            CellCalenderSchedule *cell = (CellCalenderSchedule *)gesture.view;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            
            CGFloat h = [self invoke_heightForRowAtIndexPath:indexPath];
            CGFloat w = cell.bounds.size.width;
            CGRect rect = CGRectMake(0, 0, w, h);
            CGPoint point = [gesture locationInView:cell];
            if(CGRectContainsPoint(rect,point))
            {
                [self invoke_didSelectRowAtIndexPath:indexPath];
                if (self.atomView)
                {
                    [self openOrCloseCellWithTouchType:TQCellLineTouch forIndexPath:indexPath];
                }
            }
        }

        else if([_redirectFrom isEqualToString:@"ALL_DRIVERS"])
        {
           
        }
        else if([_redirectFrom isEqualToString:@"ALL_ALERTS"])
        {
            CellAlertDetails *cell=(CellAlertDetails *)gesture.view;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            CGFloat h = [self invoke_heightForRowAtIndexPath:indexPath];
            CGFloat w = cell.bounds.size.width;
            CGRect rect = CGRectMake(0, 0, w, h);
            CGPoint point = [gesture locationInView:cell];
            if(CGRectContainsPoint(rect,point))
            {
                [self invoke_didSelectRowAtIndexPath:indexPath];
            }
        }
        else
        {
            CellMatchesContainer *cell = (CellMatchesContainer *)gesture.view;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            
            CGFloat h = [self invoke_heightForRowAtIndexPath:indexPath];
            CGFloat w = cell.bounds.size.width;
            CGRect rect = CGRectMake(0, 0, w, h);
            CGPoint point = [gesture locationInView:cell];
            if(CGRectContainsPoint(rect,point))
            {
                [self invoke_didSelectRowAtIndexPath:indexPath];
                if (self.atomView)
                {
                    [self openOrCloseCellWithTouchType:TQCellLineTouch forIndexPath:indexPath];
                }
            }
        }
        
    } 
    @catch (NSException *exception) {
        
    } 
}
#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self addTapGestureRecognizerForView:cell action:@selector(tableViewCellTouchUpInside:)];
    if ([self.openedIndexPath compare:indexPath] == NSOrderedSame)
    {
        CGFloat atomViewHeight = [self invoke_heightForAtomAtIndexPath:indexPath];
        CGFloat cellViewHeight = [self invoke_heightForRowAtIndexPath:indexPath];
        for (MatchDetailView *vwsub in cell.subviews)
        {
            if([vwsub isKindOfClass:[MatchDetailView class]])
            {
                [vwsub removeFromSuperview];
            }
        }
        self.atomView.frame = CGRectMake(self.atomOrigin.x,self.atomOrigin.y + cellViewHeight,cell.bounds.size.width, atomViewHeight);
        
        [cell addSubview:self.atomView];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [self removeTapGestureRecognizerFromView:cell];
    for (MatchDetailView *vwsub in cell.subviews)
    {
        if([vwsub isKindOfClass:[MatchDetailView class]])
        {
            [vwsub removeFromSuperview];
        }
    }
    if ([cell.subviews containsObject:self.atomView])
    {
        [self.atomView removeFromSuperview];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = [self invoke_heightForRowAtIndexPath:indexPath];
        
    if ([self.openedIndexPath compare:indexPath] == NSOrderedSame)
    {
        h += [self invoke_heightForAtomAtIndexPath:indexPath];
    }
    
    return h;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [self invoke_viewForHeaderInSection:section];
    
    if (view)
    {
        CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
        CGRect frame = CGRectMake(0, 0, tableView.bounds.size.width, height);
        view.frame = frame;
        view.tag = section;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(tableViewHeaderTouchUpInside:)];
        [view addGestureRecognizer:tapGesture];
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)])
    {
        return [self invoke_heightForHeaderInSection:section];
    }
    else
    {
        return 0;
    }
}
#pragma mark - Table View DataSource
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (endScrolling >= scrollView.contentSize.height)
    {
        //vwfooter.alpha=1;
        [self.delegate mscrollViewDidEndDecelerating:scrollView];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)] && self.openedIndexPath.section != section)
    {
        return 0;
    }
    NSInteger n = 0;
    n = [self invoke_numberOfRowsInSection:section];
    return n;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self invoke_cellForRowAtIndexPath:indexPath];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  [self invoke_numberOfSectionsInTableView];
}
#pragma mark - Invoke Delegate
- (CGFloat)invoke_heightForHeaderInSection:(NSInteger)section
{
    NSInteger h = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(mTableView: heightForHeaderInSection:)])
    {
        h = [self.delegate mTableView:self heightForHeaderInSection:section];
    }
    return h;
}
- (CGFloat)invoke_heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = kDefultHeightForRow;
    if (self.delegate && [self.delegate respondsToSelector:@selector(mTableView: heightForRowAtIndexPath:)])
    {
        h = [self.delegate mTableView:self heightForRowAtIndexPath:indexPath];
    }
    return h;
}
- (CGFloat)invoke_heightForAtomAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = kDefultHeightForAtom;
    if (self.delegate && [self.delegate respondsToSelector:@selector(mTableView: heightForAtomAtIndexPath:)])
    {
        h = [self.delegate mTableView:self heightForAtomAtIndexPath:indexPath];
    }
    return h;
}
- (UIView *)invoke_viewForHeaderInSection:(NSInteger)section
{
    UIView *view = nil;
    if(self.delegate && [self.delegate respondsToSelector:@selector(mTableView: viewForHeaderInSection:)])
    {
        view = [self.delegate mTableView:self viewForHeaderInSection:section];
    }
    return view;
}
- (void)invoke_willOpenHeaderAtSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mTableView: willOpenHeaderAtSection:)])
    {
        [self.delegate mTableView:self willOpenHeaderAtSection:section];
    }
}
- (void)invoke_willCloseHeaderAtSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mTableView: willCloseHeaderAtSection:)])
    {
        [self.delegate mTableView:self willCloseHeaderAtSection:section];
    }
}
- (void)invoke_willOpenRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mTableView: willOpenHeaderAtSection:)])
    {
        [self.delegate mTableView:self willOpenRowAtIndexPath:indexPath];
    }
}
- (void)invoke_willCloseRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mTableView: willCloseRowAtIndexPath:)])
    {
        [self.delegate mTableView:self willCloseRowAtIndexPath:indexPath];
    }
}
- (void)invoke_didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mTableView: didSelectRowAtIndexPath:)])
    {
        [self.delegate mTableView:self didSelectRowAtIndexPath:indexPath];
    }
}
#pragma mark - Invoke DataSource
- (NSInteger)invoke_numberOfRowsInSection:(NSInteger)section
{
    NSInteger n = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(mTableView: numberOfRowsInSection:)])
    {
        n = [self.dataSource mTableView:self numberOfRowsInSection:section];
    }
    return n;
}
- (UITableViewCell *)invoke_cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([_redirectFrom isEqualToString:@"ALL_EQUIPMENTS"])
    {
        CellMatchedLoadListForEquipment *cell = nil;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(mTableView: cellForRowAtIndexPath:)])
        {
            cell = (CellMatchedLoadListForEquipment*)[self.dataSource mTableView:self cellForRowAtIndexPath:indexPath];
        }
        return cell;
    }
   else if([_redirectFrom isEqualToString:@"ALL_EQUIPMENTS_ALTERNATE"])
    {
        CellCalenderSchedule *cell = nil;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(mTableView: cellForRowAtIndexPath:)])
        {
            cell = (CellCalenderSchedule*)[self.dataSource mTableView:self cellForRowAtIndexPath:indexPath];
        }
        return cell;
    }
    else if([_redirectFrom isEqualToString:@"ALL_DRIVERS"])
    {
        return nil;
    }
    else if([_redirectFrom isEqualToString:@"ALL_ALERTS"])
    {
        CellAlertDetails *cell=nil;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(mTableView: cellForRowAtIndexPath:)])
        {
            cell = (CellAlertDetails*)[self.dataSource mTableView:self cellForRowAtIndexPath:indexPath];
        }
        return cell;
    }
    else
    {
        CellMatchesContainer *cell = nil;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(mTableView: cellForRowAtIndexPath:)])
        {
            cell = (CellMatchesContainer*)[self.dataSource mTableView:self cellForRowAtIndexPath:indexPath];
        }
        return cell;
    }
   
}
- (NSInteger)invoke_numberOfSectionsInTableView
{
    NSInteger n = 1;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)])
    {
        n = [self.dataSource numberOfSectionsInTableView:self];
    }
    return n;
}
@end
