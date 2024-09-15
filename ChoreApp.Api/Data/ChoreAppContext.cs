using System;
using ChoreApp.Api.Entities;
using Microsoft.EntityFrameworkCore;

namespace ChoreApp.Api.Data
{
	public class ChoreAppContext(DbContextOptions<ChoreAppContext> options) 
	: DbContext(options)
	{
		public DbSet<Chore> Chores => Set<Chore>();
		protected override void OnModelCreating(ModelBuilder modelBuilder)
		{
			modelBuilder.Entity<Chore>()
				.Property(e => e.Deadline)
				.HasColumnType("timestamp");
			modelBuilder.Entity<Chore>()
				.Property(e => e.Done)
				.HasColumnType("bool");
		}
	}
	
}




