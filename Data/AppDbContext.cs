using Microsoft.EntityFrameworkCore;
using ApiEnfermedades.Models;

namespace ApiEnfermedades.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options){}

    public DbSet<EnfermedadCronica> EnfermedadCronicas { get; set; }
}