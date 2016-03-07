//
//  MediaTableViewCell.m
//  Blocstagram
//
//  Created by Ellen Thuy Le on 1/26/16.
//  Copyright (c) 2016 Ellen Thuy Le. All rights reserved.
//

#import "MediaTableViewCell.h"
#import "Media.h"
#import "Comment.h"
#import "User.h"
#import "LikeButton.h"

@interface MediaTableViewCell () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *mediaImageView;
@property (nonatomic, strong) UILabel *usernameAndCaptionLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) NSLayoutConstraint *imageHeightConstraint;
//@property (nonatomic, strong) NSLayoutConstraint *imageWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *usernameAndCaptionLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *commentLabelHeightConstraint;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizerWithTwoFingers;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;

@property (nonatomic, strong) LikeButton *likeButton;

@end

static UIFont *lightFont;
static UIFont *boldFont;
static UIColor *usernameLabelGray;
static UIColor *commentLabelGray;
static UIColor *linkColor;
static UIColor *firstCommentColor;
static NSParagraphStyle *paragraphStyle;
static NSParagraphStyle *evenParagraphStyle;

@implementation MediaTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.mediaImageView = [[UIImageView alloc] init];
        
        //add gesture recognizer to image view
        self.mediaImageView.userInteractionEnabled = YES;
        
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFired:)];
        self.tapGestureRecognizer.delegate = self;
        [self.mediaImageView addGestureRecognizer:self.tapGestureRecognizer];
        
        self.tapGestureRecognizerWithTwoFingers = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapWithTwoFingersFired:)];
        self.tapGestureRecognizerWithTwoFingers.numberOfTouchesRequired = 2;
        self.tapGestureRecognizerWithTwoFingers.delegate = self;
        [self.mediaImageView addGestureRecognizer:self.tapGestureRecognizerWithTwoFingers];

        self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressFired:)];
        self.longPressGestureRecognizer.delegate = self;
        [self.mediaImageView addGestureRecognizer:self.longPressGestureRecognizer];
        
        self.usernameAndCaptionLabel = [[UILabel alloc] init];
        self.usernameAndCaptionLabel.numberOfLines = 0;
        self.usernameAndCaptionLabel.backgroundColor = usernameLabelGray;
        
        self.commentLabel = [[UILabel alloc] init];
        self.commentLabel.numberOfLines = 0;
        self.commentLabel.backgroundColor = commentLabelGray;
        
        self.likeButton = [[LikeButton alloc] init];
        [self.likeButton addTarget:self action:@selector(likePressed:) forControlEvents:UIControlEventTouchUpInside];
        self.likeButton.backgroundColor = usernameLabelGray;
        
        for (UIView *view in @[self.mediaImageView, self.usernameAndCaptionLabel, self.commentLabel, self.likeButton]) {
            [self.contentView addSubview:view];
            view.translatesAutoresizingMaskIntoConstraints = NO;
        }
        
        NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_mediaImageView, _usernameAndCaptionLabel, _commentLabel, _likeButton);
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_mediaImageView]|" options:kNilOptions metrics:nil views:viewDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_usernameAndCaptionLabel][_likeButton(==38)]|" options:kNilOptions metrics:nil views:viewDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_commentLabel]|" options:kNilOptions metrics:nil views:viewDictionary]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_mediaImageView][_usernameAndCaptionLabel][_commentLabel]"
                                                                                 options:kNilOptions
                                                                                 metrics:nil
                                                                                   views:viewDictionary]];
        self.imageHeightConstraint = [NSLayoutConstraint constraintWithItem:_mediaImageView
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1
                                                                constant:100];
        self.imageHeightConstraint.identifier = @"Image height constraint";
        
//        self.imageWidthConstraint = [NSLayoutConstraint constraintWithItem:_mediaImageView
//                                                                  attribute:NSLayoutAttributeWidth
//                                                                  relatedBy:NSLayoutRelationEqual
//                                                                     toItem:nil
//                                                                  attribute:NSLayoutAttributeNotAnAttribute
//                                                                 multiplier:1
//                                                                   constant:100];
//        self.imageWidthConstraint.identifier = @"Image width constraint";
        
        self.usernameAndCaptionLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_usernameAndCaptionLabel
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1
                                                                constant:100];
        self.usernameAndCaptionLabelHeightConstraint.identifier = @"Username and caption label height constraint";
        
        self.commentLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_commentLabel
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1
                                                                constant:100];
        self.commentLabelHeightConstraint.identifier = @"Comment label height constraint";
        
        [self.contentView addConstraints:@[self.imageHeightConstraint, self.usernameAndCaptionLabelHeightConstraint, self.commentLabelHeightConstraint]];
    
    }
    return self;
}

//class method, not an instance method!
+ (void) load {
    lightFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
    boldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
    usernameLabelGray = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1]; /*#eeeeee - gray */
    commentLabelGray= [UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1]; /*#e5e5e5 - gray */
    linkColor= [UIColor colorWithRed:0.345 green:0.314 blue:0.427 alpha:1]; /*#58506d - purple */
    firstCommentColor= [UIColor colorWithRed:1 green:0.35 blue:0 alpha:1]; /*#FFA500 - orange */
    
    NSMutableParagraphStyle *mutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    mutableParagraphStyle.headIndent = 20.0;
    mutableParagraphStyle.firstLineHeadIndent = 20.0;
    mutableParagraphStyle.tailIndent = -20.0;
    mutableParagraphStyle.paragraphSpacingBefore = 5;
    
    paragraphStyle = mutableParagraphStyle;
    
    NSMutableParagraphStyle *evenMutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    evenMutableParagraphStyle.headIndent = 20.0;
    evenMutableParagraphStyle.firstLineHeadIndent = 20.0;
    evenMutableParagraphStyle.tailIndent = -20.0;
    evenMutableParagraphStyle.paragraphSpacingBefore = 5;
    evenMutableParagraphStyle.alignment = NSTextAlignmentRight;
    
    evenParagraphStyle = evenMutableParagraphStyle;
}

- (NSAttributedString *) usernameAndCaptionString {
    //#1
    CGFloat usernameFontSize = 15;
    
    //#2 - Make a string that says 'username caption'
    NSString *baseString = [NSString stringWithFormat:@"%@ %@", self.mediaItem.user.userName, self.mediaItem.caption];
    
    //#3 - Make an attributed string, with the 'username' bold
    NSMutableAttributedString *mutableUsernameAndCaptionString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [lightFont fontWithSize:usernameFontSize], NSParagraphStyleAttributeName : paragraphStyle}];
    
    //#4
    NSRange usernameRange = [baseString rangeOfString:self.mediaItem.user.userName];
    [mutableUsernameAndCaptionString addAttribute:NSFontAttributeName value:[boldFont fontWithSize:usernameFontSize] range:usernameRange];
    [mutableUsernameAndCaptionString addAttribute:NSForegroundColorAttributeName value:linkColor range:usernameRange];
    
    return mutableUsernameAndCaptionString;
}

- (NSAttributedString *) commentString {
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] init];
    
    for (int i = 0; i < self.mediaItem.comments.count; i++) {
        Comment *comment = self.mediaItem.comments[i];
        // Make a string that says "username comment" followed by a line break
        NSString *baseString = [NSString stringWithFormat:@"%@ %@\n", comment.from.userName, comment.text];
        
        // Make an attributed string, with the "username" bold
        
        NSMutableAttributedString *oneCommentString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : lightFont, NSParagraphStyleAttributeName : paragraphStyle}];
        
        NSRange firstCommentLength = NSMakeRange(0, oneCommentString.length);
        
        if (i == 0) {
            [oneCommentString addAttribute:NSForegroundColorAttributeName value:firstCommentColor range:firstCommentLength];
        } else if (i % 2) {
            [oneCommentString addAttribute:NSParagraphStyleAttributeName value:evenParagraphStyle range:firstCommentLength];
        }
        
        NSRange usernameRange = [baseString rangeOfString:comment.from.userName];
        [oneCommentString addAttribute:NSFontAttributeName value:boldFont range:usernameRange];
        [oneCommentString addAttribute:NSForegroundColorAttributeName value:linkColor range:usernameRange];
        [oneCommentString addAttribute:NSKernAttributeName value:@(2) range:firstCommentLength];
        
        [commentString appendAttributedString:oneCommentString];
    }
    
    return commentString;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    if (self.mediaItem) {
        // Before layout, calculate the intrinsic size of the labels (the size they "want" to be), and add 20 to the height for some vertical padding.
        CGSize maxSize = CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX);
        CGSize usernameLabelSize = [self.usernameAndCaptionLabel sizeThatFits:maxSize];
        CGSize commentLabelSize = [self.commentLabel sizeThatFits:maxSize];
  
        self.usernameAndCaptionLabelHeightConstraint.constant = usernameLabelSize.height == 0 ? 0 : usernameLabelSize.height + 20;
        self.commentLabelHeightConstraint.constant = commentLabelSize.height == 0 ? 0 : commentLabelSize.height + 20;
        if (self.mediaItem.image.size.width > 0 && CGRectGetWidth(self.contentView.bounds) > 0) {
            self.imageHeightConstraint.constant = self.mediaItem.image.size.height / self.mediaItem.image.size.width * CGRectGetWidth(self.contentView.bounds);
        } else {
            self.imageHeightConstraint.constant = 100;
        }
    // Hide the line between cells
    self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.bounds)/2.0, 0, CGRectGetWidth(self.bounds)/2.0);
    }
}

- (void) setMediaItem:(Media *)mediaItem {
    _mediaItem = mediaItem;
    self.mediaImageView.image = _mediaItem.image;
    self.usernameAndCaptionLabel.attributedText = [self usernameAndCaptionString];
    self.commentLabel.attributedText = [self commentString];
    self.likeButton.likeButtonState = mediaItem.likeState;
}

+ (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width {
    
    MediaTableViewCell *layoutCell = [[MediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"layoutCell"];
    
    // Make a cell
    layoutCell.mediaItem = mediaItem;
    
    layoutCell.frame = CGRectMake(0, 0, width, CGRectGetHeight(layoutCell.frame));
    
    [layoutCell setNeedsLayout];
    [layoutCell layoutIfNeeded];
    
    // Get the actual height required for the cell
    return CGRectGetMaxY(layoutCell.commentLabel.frame);
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:NO animated:animated];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:NO animated:animated];
    
}


#pragma mark - Image View

//target method which will call cell:didTapImageView:
- (void) tapFired:(UITapGestureRecognizer *)sender {
    [self.delegate cell:self didTapImageView:self.mediaImageView];
}

- (void) longPressFired:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self.delegate cell:self didLongPressImageView:self.mediaImageView];
    }
}

- (void) tapWithTwoFingersFired:(UILongPressGestureRecognizer *)sender {
    [self.delegate cell:self didTwoFingerTouchImageViewWithMediaItem:self.mediaItem];
}

#pragma mark - UIGestureRecognizerDelegate
//gesture recognizer only fires when not in editing mode
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.isEditing == NO;
}

#pragma mark - Liking
//inform the delegate that the like button was tapped
- (void) likePressed:(UIButton *)sender {
    [self.delegate cellDidPressLikeButton:self];
}

@end