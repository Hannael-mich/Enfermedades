using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ApiEnfermedades.Models;

[Table("tc_enfermedad_cronica", Schema = "schemasye")]
public class EnfermedadCronica
{
    [Key]
    [Column("id_enf_cronica")]
    public int Id { get; set; }

    [Column("nombre")]
    public string? Nombre { get; set; }

    [Column ("descripcion")]
    public string? Descripcion { get; set; }

    [Column("fecha_registro")]
    public DateTime FechaRegistro { get; set; }

    [Column("fecha_inicio")]
    public DateTime FechaInicio { get; set; }

    [Column("estado")]
    public bool Estado { get; set;}

    [Column ("fecha_actualizacion")]
    public DateTime? FechaActualizacion { get; set; }


}