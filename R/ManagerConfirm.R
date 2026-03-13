
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
#' ManagerConfirmServer()
ManagerConfirmServer <- function(input,output,session,dms_token) {
  ManagerConfirmViewServer(input = input,output = output,session = session,dms_token = dms_token)

  ManagerConfirmUpdateServer(input = input,output = output,session = session,dms_token = dms_token)


}
