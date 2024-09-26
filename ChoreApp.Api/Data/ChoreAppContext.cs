using ChoreApp.Api.Endpoints;
using ChoreApp.Api.Entities;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace ChoreApp.Api.Data
{
	public class ChoreAppContext : IdentityDbContext<User>
	{
		public ChoreAppContext(DbContextOptions<ChoreAppContext> options)
			: base(options)
		{
		}

		// DbSet for your custom entities
		public DbSet<Chore> Chores => Set<Chore>();

		// Configure your entity mappings
		protected override void OnModelCreating(ModelBuilder modelBuilder)
		{
			base.OnModelCreating(modelBuilder); // Be sure to call base method
			
			// Customize Chore entity
			modelBuilder.Entity<Chore>()
				.Property(e => e.Deadline)
				.HasColumnType("timestamp");

			modelBuilder.Entity<Chore>()
				.Property(e => e.Done)
				.HasColumnType("bool");
			modelBuilder.Entity<Chore>()
				.HasOne(c => c.AssignedUser)
				.WithMany()
				.HasForeignKey(c => c.AssignedUserId)
				.OnDelete(DeleteBehavior.SetNull);
		}
	}
}
