require 'csv'

class SuppliesController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  def index
    @supplies = Supply.order(created_at: :desc).limit(10)
    @warning_expiration = Supply.where(supply_type: "medicine").limit(15)
    @critical_supply = Supply.order(quantity: :asc, expiration: :asc).limit(15)
  end
  def new
    @supply = Supply.new
    @supply = params[:upc]
  end

  def quantity_choose

  end

  def create
    @supply = Supply.new(supply_params)
    @supply.user = current_user
    if params[:qty_per_box].present? && params[:box_quantity].present?
      @supply.initial_quantity = params[:qty_per_box].to_i * params[:box_quantity].to_i
      @supply.quantity = params[:qty_per_box].to_i * params[:box_quantity].to_i
    else
      @supply.initial_quantity = params[:quantity]
    end
    
    if @supply.save
      @user_action = UserAction.new
      if params[:qty_per_box].present? && params[:box_quantity].present?
        @user_action.action = "Created #{@supply.box_quantity} box, #{@supply.qty_per_box}pcs per box, #{@supply.name} (#{@supply.brand})"
      else
        @user_action.action = "Created #{@supply.initial_quantity}pc of #{@supply.name} (#{@supply.brand})"
      end
      @user_action.user = current_user
      @user_action.supply = @supply
      @user_action.dispense = params[:deduction]
      @user_action.user = current_user
      @user_action.ended_quantity = @supply.quantity
      @user_action.save!
      if @user_action.save
        flash[:notice] = "Created #{@supply.name} successfuly!"
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @supply = Supply.find(params[:id])
    @supply_type = @supply.supply_type
  end

  def scan

  end

  def get_barcode
    @supply = Supply.find_by(upc: params[:upc])
  
      redirect_to("/dispense/#{@supply.id}", allow_other_host: true)

  end

  def departments
    @departments = Department.all
    @users = User.all
  end


  def create_user
    @user = User.new
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.save!
    if @user.save!
      flash[:alert] = "Created user successfuly!"
      redirect_to "/user/#{@user.id}"
    else
      flash[:alert] = "Error creating user!"
      redirect_back fallback_location: root_path
    end
  end

  def show_user
    @user = User.find(params[:id])
  end

  def edit_user
    @user = User.find(params[:id])
    @user.name = params[:name]
    @user.role = params[:role]
    @user.save!
    if @user.save!
      flash[:notice] = "Updated user successfuly!"
      redirect_to "/user/#{@user.id}"
    else
      flash[:alert] = "Error updating user!"
      redirect_back fallback_location: root_path
    end
  end

  def create_department
    @department = Department.new
    @department.name = params[:name]
    @department.save!
    if @department.save!
      flash[:alert] = "Created department successfuly!"
      redirect_to "/department/#{@department.id}"
    else
      flash[:alert] = "Error creating department!"
      redirect_back fallback_location: root_path
    end
  end

  def show_department
    @department = Department.find(params[:id])
  end

  def edit_department
    @department = Department.find(params[:id])
    @department.name = params[:name]
    @department.save!
    if @department.save!
      flash[:notice] = "Updated department successfuly!"
      redirect_to "/department/#{@department.id}"
    else
      flash[:alert] = "Error updating department!"
      redirect_back fallback_location: root_path
    end
  end

  def mark_as_done
    @supply = Supply.find(params[:id])
    @supply.status = "done"
    @supply.save!
    flash[:alert] = "Mark as Done successfuly!"
    redirect_back fallback_location: root_path
  end

  def dispense
    search = params[:name] ? params[:name] : nil
    @supplies = if search
      Supply.where("lower(name) LIKE ? OR lower(brand) LIKE ?", "%#{search.downcase}%", "%#{search.downcase}%")
    else
      
    end

  end

  def dispense_show
    @supply = Supply.find(params[:id])
  end

  def dispense_supply
    @supply = Supply.find(params[:id])
    if @supply.box_quantity.present?
      if params[:box_qty_deduction].to_i > @supply.box_quantity
        flash[:alert] = "Cannot deduct more than the quantity"
        redirect_back fallback_location: root_path
      else
        @supply.box_quantity = @supply.box_quantity - params[:box_qty_deduction].to_i
        @supply.quantity = @supply.quantity - params[:box_qty_deduction].to_i * @supply.qty_per_box
        @supply.save!
        @user_action = UserAction.new
          if params[:box_qty_deduction].to_i <= 1
            @user_action.action = "Deduct #{params[:box_qty_deduction]}box of #{@supply.name} (#{@supply.brand})"
          else
            @user_action.action = "Deduct #{params[:deduction]}boxes of #{@supply.name} (#{@supply.brand})"
          end
          @user_action.user = current_user
          @user_action.supply = @supply
          @user_action.dispense = params[:box_qty_deduction].to_i
          @user_action.user = current_user
          @user_action.ended_quantity = @supply.quantity
          @user_action.department_id = params[:department]
          @user_action.save!
          if @user_action.save
            flash[:alert] = "Sucessfully deduct #{params[:deduction]}box. Stock Left: #{@supply.quantity}"
            redirect_back fallback_location: root_path
          else
            render :new, status: :unprocessable_entity
          end
      end
    else
        if params[:deduction].to_i >= @supply.quantity
          flash[:alert] = "Cannot deduct more than the quantity"
          redirect_back fallback_location: root_path
        else
          @supply.quantity = @supply.quantity - params[:deduction].to_i
          @supply.save!
          @user_action = UserAction.new
          if params[:deduction].to_i == 1
            @user_action.action = "Deduct #{params[:deduction]}pc of #{@supply.name} (#{@supply.brand})"
          else
            @user_action.action = "Deduct #{params[:deduction]}pcs of #{@supply.name} (#{@supply.brand})"
          end
          @user_action.user = current_user
          @user_action.supply = @supply
          @user_action.dispense = params[:deduction]
          @user_action.user = current_user
          @user_action.ended_quantity = @supply.quantity
          @user_action.department_id = params[:department]
          @user_action.save!
          if @user_action.save
            flash[:alert] = "Sucessfully deduct #{params[:deduction]}pcs. Stock Left: #{@supply.quantity}"
            redirect_back fallback_location: root_path
          else
            render :new, status: :unprocessable_entity
          end
        end
    end
  end

  def restock
    search = params[:name] ? params[:name] : nil
    @supplies = if search
      Supply.where("lower(name) LIKE ? OR lower(brand) LIKE ?", "%#{search.downcase}%", "%#{search.downcase}%")
    else
      
    end
  end

  def restock_show
    @supply = Supply.find(params[:id])
  end

  def restock_supply
    @supply = Supply.find(params[:id])
    if @supply.box_quantity.present?
      @supply.box_quantity = @supply.box_quantity + params[:box_qty_restock].to_i
      @supply.quantity = @supply.quantity + params[:box_qty_restock].to_i * @supply.qty_per_box
      @supply.save!
      @user_action = UserAction.new
        if params[:box_qty_restock].to_i <= 1
          @user_action.action = "Added #{params[:box_qty_restock]}box of #{@supply.name} (#{@supply.brand})"
        else
          @user_action.action = "Added #{params[:box_qty_restock]}boxes of #{@supply.name} (#{@supply.brand})"
        end
        @user_action.user = current_user
        @user_action.supply = @supply
        @user_action.dispense = params[:box_qty_restock].to_i
        @user_action.user = current_user
        @user_action.ended_quantity = @supply.quantity
        @user_action.save!
        if @user_action.save
          flash[:alert] = "Sucessfully added #{params[:deduction]}pcs. Stock Left: #{@supply.quantity}"
          redirect_back fallback_location: root_path
        else
          render :new, status: :unprocessable_entity
        end
    else
      @supply.quantity = @supply.quantity + params[:deduction].to_i
      @supply.save!
      @user_action = UserAction.new
      if params[:deduction].to_i == 1
        @user_action.action = "Added #{params[:deduction]}pc of #{@supply.name} (#{@supply.brand})"
      else
        @user_action.action = "Added #{params[:deduction]}pcs of #{@supply.name} (#{@supply.brand})"
      end
      @user_action.user = current_user
      @user_action.supply = @supply
      @user_action.dispense = params[:deduction]
      @user_action.user = current_user
      @user_action.ended_quantity = @supply.quantity
      @user_action.save!
      if @user_action.save
        flash[:alert] = "Sucessfully added #{params[:deduction]}pcs. Stock Left: #{@supply.quantity}"
        redirect_back fallback_location: root_path
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def update
    @supply = Supply.find(params[:id])
    @supply_type = @supply.supply_type
    if @supply.update(supply_params)
      flash[:notice] = "Updated successfuly!"
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def export_reports

  end

  def export 
    if params[:to].present? && params[:from].present? 
      start_date = params[:from]
      end_date = params[:to] 
      if start_date > end_date
      flash[:alert] = "Cannot proceed! Start Date is greater than End Date"
      redirect_back fallback_location: root_path
      else
        @user_actions = UserAction.all.order(created_at: :desc).where("created_at >= ? AND created_at <= ?", start_date.to_datetime, end_date.to_date.at_end_of_day)
        @medical_supplies = Supply.where(supply_type: "medical_supply").order(created_at: :desc).where("created_at >= ? AND created_at <= ?", start_date, end_date)
        @medicine_supply = Supply.where(supply_type: "medicine").order(created_at: :desc).where("created_at >= ? AND created_at <= ?", start_date, end_date)
        respond_to do |format|
          format.pdf do
            render pdf: "file_name", template: "supplies/daily", formats: :html
          end
        end
      end
    else
      @type_of_report = params[:set]
      if @type_of_report == "daily"
        @user_actions = UserAction.all.order(created_at: :desc)
        @medical_supplies = Supply.where(supply_type: "medical_supply").order(created_at: :desc)
        @medicine_supply = Supply.where(supply_type: "medicine").order(created_at: :desc)
      elsif @type_of_report == "weekly"
        start_date = Date.today.at_beginning_of_week
        end_date = Date.today.at_end_of_week
        @user_actions = UserAction.all.order(created_at: :desc).where("created_at >= ? AND created_at <= ?", start_date, end_date)
        @medical_supplies = Supply.where(supply_type: "medical_supply").where("created_at >= ? AND created_at <= ?", start_date, end_date).order(created_at: :desc)
        @medicine_supply = Supply.where(supply_type: "medicine").where("created_at >= ? AND created_at <= ?", start_date, end_date).order(created_at: :desc)
      elsif @type_of_report == "monthly"
        start_date = Date.today.at_beginning_of_month
        end_date = Date.today.at_end_of_month
        @user_actions = UserAction.all.order(created_at: :desc).where("created_at >= ? AND created_at <= ?", start_date, end_date)
        @medical_supplies = Supply.where(supply_type: "medical_supply").order(created_at: :desc).where("created_at >= ? AND created_at <= ?", start_date, end_date)
        @medicine_supply = Supply.where(supply_type: "medicine").order(created_at: :desc).where("created_at >= ? AND created_at <= ?", start_date, end_date)
      else
        @user_actions = UserAction.all.order(created_at: :desc).limit(10)
        @medical_supplies = Supply.where(supply_type: "medical_supply").order(created_at: :desc).limit(10)
        @medicine_supply = Supply.where(supply_type: "medicine").order(created_at: :desc).limit(10)
      end
      respond_to do |format|
        format.pdf do
          render pdf: "file_name", template: "supplies/daily", formats: :html
        end
      end
    end
  end

  def show_medicines
    @pagy, @supplies = pagy((Supply.where(supply_type: "medicine").order(created_at: :desc, expiration: :asc)), items: 20) 
  end

  def critical_medicines
    @pagy, @supplies = pagy((Supply.where(supply_type: "medicine").order(expiration: :asc)), items: 20)  
  end

  def show_medical_supplies
    @pagy, @supplies = pagy((Supply.where(supply_type: "medical_supply").order(created_at: :desc)), items: 20) 
  end
  
  def critical_medical_supplies
    @pagy, @supplies = pagy((Supply.where(supply_type: "medical_supply").order(quantity: :asc, expiration: :asc)), items: 20) 
  end


  def daily_report
    @pagy, @user_actions = pagy((UserAction.all.order(created_at: :desc)), items: 20)  
  end

  def daily_report_medical_supply
    @pagy, @supplies = pagy((Supply.where(supply_type: "medical_supply").order(created_at: :desc)), items: 20)  
  end

  def daily_report_medicine
    @pagy, @supplies = pagy((Supply.where(supply_type: "medicine").order(created_at: :desc)), items: 20)  
  end

  private

  def supply_params
    params.permit(:name, :brand, :description, :quantity, :expiration, :expiration_warning, :supply_type, :initial_quantity, :box_quantity, :qty_per_box, :upc)
  end
end
