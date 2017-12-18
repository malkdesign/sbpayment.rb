require_relative '../../request'
require_relative '../../response'

module Sbpayment
  module API
    module Credit
      class ContinuedBillingRequest < Request
        class Detail
          include ParameterDefinition

          tag 'dtl'
          key :dtl_rowno
          key :dtl_item_id
          key :dtl_item_name, type: :M
          key :dtl_item_count
          key :dtl_tax
          key :dtl_amount
        end

        class PayOptionManage
          include ParameterDefinition

          tag 'pay_option_manage'
          key :token
          key :token_key
          key :cardbrand_return_flg, default: '1'
        end

        class MonthlyCharge
          include ParameterDefinition

          tag 'monthly_charge'
          key :div_settele, default: '1'
          key :last_charge_month
          key :camp_type, default: '0'
        end

        tag 'sps-api-request', id: 'ST01-00132-101'
        key :merchant_id, default: -> { Sbpayment.config.merchant_id }
        key :service_id,  default: -> { Sbpayment.config.service_id }
        key :cust_code
        key :order_id
        key :item_id
        key :item_name
        key :tax
        key :amount
        key :free1
        key :free2
        key :free3
        key :order_rowno
        key :sps_cust_info_return_flg, default: '1'
        many :dtls
        key :pay_option_manage, class: PayOptionManage
        key :monthly_charge, class: MonthlyCharge
        key :encrypted_flg, default: '1'
        key :request_date, default: -> { TimeUtil.format_current_time }
        key :limit_second
        key :sps_hashcode
      end

      class ContinuedBillingResponse < Response
        DECRYPT_PARAMETERS = %i(res_pay_method_info.cc_company_code
                                res_pay_method_info.cardbrand_code
                                res_pay_method_info.recognized_no).freeze
      end
    end
  end
end
