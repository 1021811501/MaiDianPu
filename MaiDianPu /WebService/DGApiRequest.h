//
//  DGApiRequest.h
//  WaRenQiSeller
//
//  Created by JasonLee on 2017/6/13.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    
    //Login
    ApiRequestTypeLogin,    //登录
    ApiRequestTypeCheckUserExist,  //判断用户是否存在
    ApiRequestTypePostMessage,      //找回密码给用户发送验证码
    ApiRequestTypeCheckMessageIsCurrect, //判断验证码是否正确
    ApiRequestTypeChangePsw,     //修改密码
    ApiRequestTypePostRegistMessage,//注册发送验证码
     ApiRequestTypeRegist,   //注册
    
    //Home
    ApiRequestTypeUserIngotInfo, //获取用户金币本金信息
    ApiRequestTypeTodayIngot, //首页今天获得的金币
    ApiRequestTypeHomeInfo, //首页信息
    ApiRequestTypekNoticeListInfo,  //首页滚动公告
    ApiRequestTypeDeviceInfo,  //首页上传设备信息
    
    //TaskHall
    ApiRequestTypeGetTaskCount, //任务大厅,获取个状态任务数量
    ApiRequestTypePassTBAccount,//已通过的买号
    ApiRequestTypeTaskList, //流量任务列表
    ApiRequestTypeSDTaskList, //垫付任务列表
    ApiRequestTypeReceiveFlowTask,//领取流量任务
    ApiRequestTypeIsRealName, //是否实名认证
    ApiRequestTypeReceiveSDTask, //接收垫付任务
    ApiRequestTypeAutoReceiveOrderInfo, //自动派单当前状态是否在派单
    ApiRequestTypeReceiveOrder,   //派单
    ApiRequestTypeAnswerTaskList, //回答问大家任务列表
    ApiRequestTypeMyAskAndCommentPayTaskList,   //问大家追评任务列表
    ApiRequestTypeFindAskAndCommentPayTask,   //搜索问大家追评任务
    ApiRequestTypeSaveQuestionTask,         //提交追评问大家任务
    ApiRequestTypeQuestionTaskDetail,       //问大家追评任务详情

    //MyTask
    ApiRequestTypeMyFlowTaskCount,//我的流量任务数量
    ApiRequestTypeMyPayTaskCount, //我的垫付任务数量
    ApiRequestTypeMyAnswerAndCommentTaskCount, //我的回答问大家追评任务数量
    ApiRequestTypeMyFlowList, //我的流量任务列表
    ApiRequestTypeFindFlowTaskById, //搜索流量任务
    ApiRequestTypeMyPayTaskListBytatus, //我的垫付任务列表
    ApiRequestTypeFindPayTaskListBytatus,//搜索垫付任务
    
    //OperateFlowTask
    ApiRequestTypeCancleFlowTask, //取消我的流量任务
    ApiRequestTypeFlowTaskDetailInfo,               //流量任务详情
    ApiRequestTypeCheckUrlAddress,                  //核对链接地址
    ApiRequestTypeSaveFlowTaskSearchImage,          //上传搜索截图
    ApiRequestTypeCommitFlowTask,               //提交流量任务
    
    //OperatePayTask
    ApiRequestTypeDelayMyPayTask,     //垫付任务延时
    ApiRequestTypeCancleMyPayTask,   //取消我的垫付任务
    ApiRequestTypeFindPayTaskById,              //垫付任务详情
    ApiRequestTypeCheckGoodsAddress,   //核对商品链接
    ApiRequestTypeCommitPayTask,   //提交垫付任务
    ApiRequestTypeCommitCommentForPayTask,   //提交垫付任务好评
    ApiRequestTypeChageOrderImage,   //修改订单截图
    ApiRequestTypeChageLogisticsAndCommentImage,   //修改物流/好评截图
    
    
    //Profile
    ApiRequestTypeFoundBankAccount,         //银行卡信息
    ApiRequestTypeModifyQQ,                 //修改qq号码
    ApiRequestTypeRegistAndModifyMobileCheckValidCode,  //注册修改手机验证验证码
    ApiRequestTypeModifyMobile,                 //修改手机号码
    ApiRequestTypeModifyUserHeadImage,              //修改用户头像
    ApiRequestTypeModifyUserAddress,                //修改用户地址
    ApiRequestTypeModifyUserPassWord,               //修改用户密码
    ApiRequestTypeModifyUserPayPassWord,            //修改用户支付密码
}ApiRequestType;

//requestMethod
typedef enum{
    ApiRequestMethodGet,
    ApiRequestMethodPost,
    ApiRequestMethodDelete,
    ApiRequestMethodPut,
}ApiRequestMethod;

typedef enum {
    ApiRequestContentJSON,
    ApiRequestContentImage,
    ApiRequestContentPlain,
    ApiRequestContentMultipart,
} ApiRequestContent;

@interface DGApiRequest : NSObject
@property (nonatomic, assign)NSInteger timeout;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, strong)NSMutableDictionary *parameters;
@property (nonatomic, assign)ApiRequestMethod method;
@property (nonatomic, assign)ApiRequestType requestType;
@property (nonatomic, assign)ApiRequestContent content;
@property (nonatomic, strong) NSURLSessionConfiguration *configuration;
- (NSString *)assembleParameters;
- (void)setJsonHTTPHeadersForRequest:(NSMutableURLRequest *)request;
+(instancetype)defaultRequestWithUrlStr:(NSString *)urlStr;
@end
