require 'rails_helper'

describe 'Income', type: :feature do
  before do
    visit '/'
  end

  it 'create' do
    Account.create name: 'Account#1', start_balance: 10
    click_on 'Incomes'

    click_on 'New'

    fill_in 'Description', with: 'Income#1'
    fill_in 'Category', with: 'Food'
    expect(page).to have_field 'Paid at', with: Date.current.to_s
    fill_in 'Paid at', with: '2015-05-31'
    fill_in 'Value', with: '101'
    select 'Account#1', from: 'Account'

    click_on 'Create'

    expect(page).to have_content 'Income was successfully created.'

    expect(page).to have_content 'Description: Income#1'
    expect(page).to have_content 'Account: Account#1'
    expect(page).to have_content 'Category: Food'
    expect(page).to have_content 'Paid at: 2015-05-31'
  end

  it 'update' do
    income = Income.create description: 'Income#1',
      value: 100,
      paid_at: Date.current,
      account: Account.create(name: 'Account#1')

    visit edit_income_path(income)

    fill_in 'Description', with: 'Income#2'
    fill_in 'Paid at', with: '2014-12-31'

    click_on 'Update'

    expect(page).to have_content 'Income was successfully updated.'
    expect(page).to have_content 'Description: Income#2'
    expect(page).to have_content 'Paid at: 2014-12-31'
  end
end