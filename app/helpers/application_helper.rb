# coding: utf-8
module ApplicationHelper

  def show_menu
    render partial: 'shared/menu' if user_signed_in?
  end

  def show_submit_action(operation)
    case operation
    when 'booty' then 'Sacar'
    when 'deposit' then 'Depositar'
    end
  end

  def show_title(operation)
    op = case operation
    when 'booty' then 'Saque'
    when 'deposit' then 'Depósito'
    end
    "Dados para #{op}"
  end

  def show_flash(flash)
    unless flash.nil? || flash.empty?
      clazz = case flash.first.first
        when :notice ; 'alert alert-success'
        when :alert ; 'alert alert-error'
        when :warning ; 'alert alert-warning'
      end
      content_tag(:div, class: clazz) do
        content_tag(:button, 'x', class: 'close', data: { dismiss: "alert" }) +
        content_tag(:h3, flash.first.second)
      end
    end
  end

  def to_real(value)
    number_to_currency(value, unit: "R$ ", separator: ".")
  end

end