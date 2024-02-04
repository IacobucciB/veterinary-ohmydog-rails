class TipoTurnosController< ApplicationController
  def update
    @tipo_turno = TipoTurno.find(params[:id])

    if @tipo_turno.update(tipo_turno_params)
      redirect_to root_path, notice: 'TipoTurno was successfully updated.'
    else
      # Handle errors, if any
      render :edit
    end
  end

  private

  def tipo_turno_params
    # Define your permitted parameters here
    params.require(:tipo_turno).permit(:nombre, :descripcion, :monto, :dosis, :peso)
  end
end
