class Contrato < ActiveRecord::Base
  attr_accessible :contratante, :fim, :funcao, :hora_mes, :inicio, :tipo, :usuario_id, :valor_hora, :dia_inicio_periodo

  def periodo_vigente(data)
    if data.day < dia_inicio_periodo
      inicio_periodo = (data.change(day: dia_inicio_periodo) - 1.month)
      fim_periodo = data.change(day: dia_inicio_periodo) - 1.day
    else
      inicio_periodo = (data.change(day: dia_inicio_periodo))
      fim_periodo = data.change(day: dia_inicio_periodo) - 1.day + 1.month
    end
    inicio_periodo = inicio if inicio_periodo < inicio
    fim_periodo = fim if fim_periodo > fim
    inicio_periodo .. fim_periodo
  end

  def atividades_no_periodo(periodo)
    Atividade.where(:usuario_id => usuario_id).where{(data >= periodo.first) & (data < periodo.last)}
  end

  def atividades
    Atividade.where(data: (inicio .. fim), usuario_id: usuario_id)
  end

  def periodos
    resposta = Array.new
    i=0
    periodo = periodo_vigente(inicio + i.month)
    while periodo.last > periodo.first do
      resposta << periodo
      i += 1
      periodo = periodo_vigente(inicio + i.month)
    end
    resposta
  end

end
