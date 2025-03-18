﻿using Microsoft.EntityFrameworkCore;
using minimalAPi_sample.models;

namespace minimalAPi_sample.data

{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<User> Users { get; set; }
        public DbSet<Product> Products { get; set; }
    }
}
