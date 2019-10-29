//
//  FetchOfficesVC.m
//  Lodr
//
//  Created by C205 on 15/05/19.
//  Copyright © 2019 checkmate. All rights reserved.
//

#import "FetchOfficesVC.h"

@interface FetchOfficesVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation FetchOfficesVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrOffices.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(didSelectOffice:)])
    {
        [_delegate didSelectOffice:_arrOffices[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"idFetchOfficesCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UITableViewCell class]) bundle:nil] forCellReuseIdentifier:cellId];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([UITableViewCell class]) owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    OfficeDetails *objCompany = _arrOffices[indexPath.row];
    cell.textLabel.text = objCompany.officeName;
    
    return cell;
}

#pragma mark - Button Click Events

- (IBAction)btnBackClicked:(id)sender
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
