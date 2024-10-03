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
		public DbSet<Group> Groups => Set<Group>();

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
				.OnDelete(DeleteBehavior.SetNull);
			modelBuilder.Entity<User>()
				.HasMany(u => u.Groups)
				.WithMany()
				.UsingEntity("UserGroup",
				l => l.HasOne(typeof(Group)).WithMany().HasForeignKey("GroupsId").HasPrincipalKey(nameof(Group.Id)),
				r => r.HasOne(typeof(User)).WithMany().HasForeignKey("UsersId").HasPrincipalKey(nameof(User.Id)),
				j => j.HasKey("GroupsId", "UsersId"));
		}
	}
}
