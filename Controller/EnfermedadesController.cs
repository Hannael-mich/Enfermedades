using Microsoft.AspNetCore.Mvc;
//using Microsoft.EntityFrameworkCore;
using ApiEnfermedades.Data;
using ApiEnfermedades.Models;
using Microsoft.EntityFrameworkCore;


namespace ApiEnfermedades.Controllers;

[ApiController]
[Route("api/[controller]")]
public class EnfermedadesController : ControllerBase
{
    private readonly AppDbContext _context;

    public EnfermedadesController(AppDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<EnfermedadCronica>>> Get()
    {
        return await _context.EnfermedadCronicas.ToListAsync();
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<EnfermedadCronica>> GetById(int id)
    {
        var enfermedad = await _context.EnfermedadCronicas.FindAsync(id);
        if(enfermedad == null)
            return NotFound();
        return enfermedad;
    }

    [HttpPost]
    public async Task<ActionResult<EnfermedadCronica>> Create(EnfermedadCronica enf)
    {
        _context.EnfermedadCronicas.Add(enf);
        await _context.SaveChangesAsync();
        return CreatedAtAction(nameof(GetById), new { id = enf.Id}, enf);
    }

    [HttpPut("{id}")]
    public async Task<ActionResult> Update (int id, EnfermedadCronica enf)
    {
        if(id != enf.Id) return BadRequest();
        _context.Entry(enf).State = EntityState.Modified;
        await _context.SaveChangesAsync();
        return NoContent();
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        var enf = await _context.EnfermedadCronicas.FindAsync(id);
        if (enf == null) return NotFound();
        _context.EnfermedadCronicas.Remove(enf);
        await _context.SaveChangesAsync();
        return NoContent();
    }

}
