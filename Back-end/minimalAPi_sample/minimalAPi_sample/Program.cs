using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using minimalAPi_sample.data;
using minimalAPi_sample.models;
using System.Security.Cryptography;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Register the DbContext with SQL Server
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// Register User API
app.MapPost("/Register", async (AppDbContext dbContext, [FromBody] User newUser) =>
{
    // Check if username already exists
    var existingUser = await dbContext.Users.FindAsync(newUser.username);
    if (existingUser != null)
    {
        return Results.Conflict(new { message = "Username already taken" });
    }

    // Hash password before storing it (recommended)
    newUser.password = HashPassword(newUser.password);

    // Add user to database
    dbContext.Users.Add(newUser);
    await dbContext.SaveChangesAsync();

    return Results.Created($"/users/{newUser.username}", new { message = "User registered successfully" });
});

// Login API
app.MapPost("/Login", async (AppDbContext dbContext, [FromBody] User loginUser) =>
{
    var user = await dbContext.Users.FirstOrDefaultAsync(u =>
        u.username == loginUser.username);

    if (user != null && VerifyPassword(loginUser.password, user.password))
    {
        return Results.Ok(new { message = "Login successful", user.username });
    }
    return Results.Unauthorized();
});

app.MapPost("/products", async (AppDbContext dbContext, [FromBody] Product newProduct) =>
{
    dbContext.Products.Add(newProduct);
    await dbContext.SaveChangesAsync();
    return Results.Created($"/products/{newProduct.Id}", newProduct);
});

// Get all products saved
app.MapGet("/products", async (AppDbContext dbContext) =>
{
    var products = await dbContext.Products.ToListAsync();
    return Results.Ok(products);
});

app.UseHttpsRedirection();
app.Run();

// Helper functions for password hashing
static string HashPassword(string password)
{
    using (SHA256 sha256 = SHA256.Create())
    {
        byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
        return Convert.ToBase64String(bytes);
    }
}

static bool VerifyPassword(string inputPassword, string hashedPassword)
{
    return HashPassword(inputPassword) == hashedPassword;
}






