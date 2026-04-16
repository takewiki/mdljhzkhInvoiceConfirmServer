
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
#' ManagerConfirmViewServer()
ManagerConfirmViewServer <- function(input,output,session,dms_token) {
  #获取参数

  shiny::observeEvent(input$btn_ManagerConfirm_view,{


    data = mdljhzkhInvoiceConfirmPkg::ManagerConfirm_view(dms_token =dms_token )

    tsui::run_dataTable2(id ='ManagerConfirm_resultView' ,data = data)

    tsui::run_download_xlsx(id = 'dl_ManagerConfirm',data =data ,filename ='对账单.xlsx' )









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
#' ManagerConfirmUpdateServer()
ManagerConfirmUpdateServer <- function(input,output,session,dms_token) {
  #获取参数
  text_ManagerConfirm_FBillNO = tsui::var_text('text_ManagerConfirm_FBillNO')

  shiny::observeEvent(input$btn_ManagerConfirm_confirm,{

    FBILLNO=text_ManagerConfirm_FBillNO()







    if(FBILLNO==''  || is.null(FBILLNO)){

      tsui::pop_notice("请填写对账单号")


    }else{

      data_id = mdljhzkhInvoiceConfirmPkg::ManagerConfirm_id(dms_token = dms_token,statementNo =FBILLNO )


      id <- as.character(data_id)


      mdljhzkhInvoiceConfirmr::ChecknoteConfirm(statementNo =FBILLNO )


      mdljhzkhInvoiceConfirmr::ChecknoteInvoice(statementNo = FBILLNO)

      mdljhzkhInvoiceConfirmr::ChecknotedeleteMessage(statementID =id)


      mdljhzkhInvoiceConfirmPkg::ManagerConfirm_isdo(dms_token = dms_token,statementNo = FBILLNO)

      tsui::pop_notice("确认完成")


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
#' ManagerConfirmServer()
ManagerConfirmServer <- function(input,output,session,dms_token) {
  ManagerConfirmViewServer(input = input,output = output,session = session,dms_token = dms_token)

  ManagerConfirmUpdateServer(input = input,output = output,session = session,dms_token = dms_token)


}
