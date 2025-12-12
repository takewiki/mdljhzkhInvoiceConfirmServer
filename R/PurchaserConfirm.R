
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
#' PurchaserConfirmViewServer()
PurchaserConfirmViewServer <- function(input,output,session,dms_token) {
  #获取参数


  shiny::observeEvent(input$btn_PurchaserConfirm_view,{

    data = mdljhzkhInvoiceConfirmPkg::PurchaserConfirm_view(dms_token =dms_token)

    tsui::run_dataTable2(id ='PurchaserConfirm_resultView' ,data = data)

    tsui::run_download_xlsx(id = 'dl_PurchaserConfirm',data =data ,filename ='对账单.xlsx' )






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
#' PurchaserConfirmUpdateServer()
PurchaserConfirmUpdateServer <- function(input,output,session,dms_token) {
  #获取参数
  text_PurchaserConfirm_checknote = tsui::var_file('text_PurchaserConfirm_checknote')

  shiny::observeEvent(input$btn_PurchaserConfirm_checknote_update,{

    filename=text_PurchaserConfirm_checknote()

    if(filename==''  || is.null(filename)){

      tsui::pop_notice("请先上传文件")


    }else{

      data <- readxl::read_excel(filename,col_types = c("numeric","text","date","date","numeric","numeric","text",
                                                        "numeric","numeric","numeric","text","numeric","text","text","text","text",
                                                        "text","text","text","text","numeric","date","text","numeric"


                                                        ))

      data = as.data.frame(data)
      data = tsdo::na_standard(data)

      tsda::db_writeTable2(token = dms_token,table_name = 'rds_zkh_src_t_pur_checkNote_ByPOEntry_input',r_object = data,append = TRUE)


      mdljhzkhInvoiceConfirmPkg::PurchaserConfirm_update(dms_token = dms_token)
      tsui::pop_notice("更新成功")


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
#' PurchaserConfirmServer()
PurchaserConfirmServer <- function(input,output,session,dms_token) {
  PurchaserConfirmViewServer(input = input,output = output,session = session,dms_token = dms_token)

  PurchaserConfirmUpdateServer(input = input,output = output,session = session,dms_token = dms_token)


}
