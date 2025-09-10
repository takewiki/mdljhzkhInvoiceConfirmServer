
#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' InvoiceApplyQueryServer()
InvoiceApplyQueryServer <- function(input,output,session,dms_token) {

  #获取参数
  text_InvoiceApply_FBillNO = tsui::var_text('text_InvoiceApply_FBillNO')

  shiny::observeEvent(input$btn_InvoiceApply_query,{


    statementNo=text_InvoiceApply_FBillNO()

    if(statementNo==''  || is.null(statementNo)){

      tsui::pop_notice("请填写对账单号")



    }else{
      statementNo=text_InvoiceApply_FBillNO()
      clientId = "A775726"
      clientSecret = "1qaz3edc"
      username = "M2_JaourHotMeltA"
      password = "ef73781effc5774100f87fe2f437a435"
      res=try({
        mdl =  tsda::import('pyzkh.invoice')
        app = mdl$Invoice(clientId=clientId,
                          clientSecret=clientSecret,
                          userName=username,password=password,env="prd",debug=0)
        app$query(statementNo=statementNo)
      })

      print(res)
      tsui::pop_notice(res)


      #tsui::run_dataTable2(id ='InvoiceApply_resultView' ,data = data)



    }


  })



}


#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' InvoiceApplyApplyServer()
InvoiceApplyApplyServer <- function(input,output,session,dms_token) {
  #获取参数
  text_InvoiceApply_FBillNO = tsui::var_text('text_InvoiceApply_FBillNO')

  shiny::observeEvent(input$btn_InvoiceApply_apply,{

    statementNo=text_InvoiceApply_FBillNO()

    if(statementNo==''  || is.null(statementNo)){

      tsui::pop_notice("请填写对账单号")


    }else{
      statementNo=text_InvoiceApply_FBillNO()
      clientId = "A775726"
      clientSecret = "1qaz3edc"
      username = "M2_JaourHotMeltA"
      password = "ef73781effc5774100f87fe2f437a435"

      try({
        mdl =  tsda::import('pyzkh.invoice')
        app = mdl$Invoice(clientId=clientId,
                          clientSecret=clientSecret,
                          userName=username,password=password,env="prd",debug=0)
        app$apply(statementNo=statementNo)
      })
      tsui::pop_notice("申请完成")




    }


  })



}


#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' InvoiceApplyServer()
InvoiceApplyServer <- function(input,output,session,dms_token) {
  InvoiceApplyQueryServer(input = input,output = output,session = session,dms_token = dms_token)

  InvoiceApplyApplyServer(input = input,output = output,session = session,dms_token = dms_token)


}
