class StopController < ApplicationController
  def index
    @stopdescriptions = Stopdescriptions.all
  end
end
