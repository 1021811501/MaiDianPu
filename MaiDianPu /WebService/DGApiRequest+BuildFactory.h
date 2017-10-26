//
//  DGApiRequest+BuildFactory.h
//  WaRenQiSeller
//
//  Created by JasonLee on 2017/6/13.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DGApiRequest.h"

@interface DGApiRequest (BuildFactory)
////登录
//+(instancetype)requestForLoginInWithNick:(NSString *)nick andPassWord:(NSString *)pwd;
////判断用户是否存在
//+(instancetype)requestForCheckUserExistWith:(NSString *)phoneNum;
////修改密码发送验证信息
//+(instancetype)requestForSendMessageWithPhoneNum:(NSString *)phoneNum;
//
////修改密码验证验证码
//+(instancetype)requestForCheckMessageIsCurrectWith:(NSString *)phoneNum andValidCode:(NSString *)validCode;
////更改密码
//+(instancetype)requestForChangePswWith:(NSString *)phoneNum andPsw:(NSString *)psw;
////注册发送验证码
//+(instancetype)requestForSendMessageWithPhoneNum:(NSString *)phoneNum andUserNick:(NSString *)nick;
////注册验证验证码是否正确
//+(instancetype)requestForCheckRegistValidateCodeIsCurrectWithNick:(NSString *)nick andValidCode:(NSString *)validCode;
////注册
//+(instancetype)requestForRegistWithNick:(NSString *)nick andPsw:(NSString *)psw andQQ:(NSString *)qqNum andPhone:(NSString *)phoneNum andInviteCode:(NSString *)inviteCode;
////用户金币
//+(instancetype)requestForUserIngotInfo;
////今日收入
//+(instancetype)requestForTodayIngotInfo;
////首页信息
//+(instancetype)requestForHomeInfo;
////首页滚动消息
//+(instancetype)requestForHomeNoticeListInfo;
////首页提交用户设备信息
//+(instancetype)requestForPostDeveiceInfo;
////各类型任务的数量
//+(instancetype)requestForTaskHallTaskCount;
////已通过的买号
//+(instancetype)requestForPassAccount;
//
////流量任务列表
//+(instancetype)requestForFlowTaskListWithPageNum:(int)pageNum andTaskType:(NSString *)taskType andAccountId:(int)accountId;
////垫付任务列表
//+(instancetype)requestForSDTaskListWithPageNum:(int)pageNum andTaskType:(NSString *)taskType andAccountId:(int)accountId;
////领取流量任务
//+(instancetype)requestForReceiveFlowTaskWithTaskId:(long long )taskId andId:(int)subTaskId andBuyerAccountID:(int)accountId andBuyerNick:(NSString *)nick;
////判断是否实名认证
//+(instancetype)requestForIsRealName;
////接收垫付任务
//+(instancetype)requestForReceiveSdTaskWithTaskId:(long long )taskId andBuyerAccountId:(int)accountId;
////自动派单当前状态
//+(instancetype)requestForAutoReceiveOrderInfoWithUserID:(NSString *)userID;
////派单
//+(instancetype)requestForReceiveOrdeWithUserID:(NSString *)userID andTaskType:(NSString *)taskType andIds:(NSString *)ids;
////回答问大家任务列表
//+(instancetype)requestForAnswerTaskListWithPageNum:(int)pageNum andPageSize:(int)pageSize;
////我的流量任务count
//+(instancetype)requestForMyFlowTaskCount;
////我的垫付任务count
//+(instancetype)requestForMyPayTaskCount;
////我的问大家追评任务count
//+(instancetype)requestForMyAnswerAndCommentTaskCount;
////我的流量任务列表
//+(instancetype)requestForFlowTaskListByStatus:(NSString *)taskStatus andPageNum:(int)pageNum andPageSize:(int)pageSize;
////取消我的流量任务
//+(instancetype)requestForCancleFlowTaskWithTaskID:(long long)taskId andReason:(NSString *)reason;
////根据id查找任务
//+(instancetype)requestForFindTaskById:(long long)Id;
////我的垫付任务列表
//+(instancetype)requestForMyPayTaskListByStatus:(NSString *)taskStatus andPageNum:(int)pageNum andPageSize:(int)pageSize;
////根据id查找我的垫付任务
//+(instancetype)requestForFindPayTaskListByStatus:(NSString *)taskStatus andPageNum:(int)pageNum andPageSize:(int)pageSize andTaskId:(long long)taskID;
////我的垫付任务延时15分钟
//+(instancetype)requestForDelayMyPayTaskWithTaskID:(long long)taskId;
////取消我的垫付任务
//+(instancetype)requestForCancleMyPayTaskWithTaskID:(long long)taskId andMemo:(NSString *)memo;
////追评问大家列表
//+(instancetype)requestForAskAndCommentTaskListWithTaskStatus:(NSString *)taskStatus andPageNum:(int)pageNum andPageSize:(int)pageSize;
////搜索追评问大家
//+(instancetype)requestForFindAskTaskWithID:(long long)taskID;
////提交追评问大家任务
//+(instancetype)requestForPostAskAndCommentTaskWithTaskID:(long long)taskID andAddCommentImg:(NSString *)commentImg andAskImg:(NSString *)askImg;
////问大家追评详情
//+(instancetype)requestForAskAndCommentTaskDetailWithTaskId:(long long)taskId;
////判断是否有银行卡
//+(instancetype)requestForFoundBankAccount;
////修改qq
//+(instancetype)requestForModifyQQWithQQ:(NSString *)qqNum andUserId:(long )userId;
////修改手机号码
//+(instancetype)requestForModifyMobileWithMobile:(NSString *)mobile andUserID:(long )userID;
////修改用户信息
//+(instancetype)requestForModifyUserInfoWithDic:(NSDictionary *)dic andRequestType:(ApiRequestType)requestType;
////修改用户地址
//+(instancetype)requestForModifyUserAddressWithProvince:(NSString *)province andCity:(NSString *)city andArea:(NSString *)area;
////流量任务详情
//+(instancetype)requestForFlowTaskDetailInfoWithTaskId:(long long)taskId;
////核对链接地址
//+(instancetype)requestForCheckUrlAddressWithTaskID:(long long)taskID andUrlAddress:(NSString *)urlAddress andTaskType:(NSString *)taskType;
////上传搜索截图
//+(instancetype)requestForUploadSearchImageWithUrl:(NSString *)url andTaskId:(int)taskID;
////提交流量任务
//+(instancetype)requestForCommitFlowTaskWithDictionary:(NSDictionary *)urlDic andTaskId:(int )taskID;

@end
