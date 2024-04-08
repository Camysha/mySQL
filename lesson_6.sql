-- Создание процедуры:
DROP PROCEDURE IF EXISTS procedure_name;
DELIMITER //
CREATE PROCEDURE procedure_name(parameter_list)
BEGIN
  statements;
  statements;
  statements;
END //
DELIMITER ;

-- Вызов процедуры:
CALL procedure_name(argument_list);