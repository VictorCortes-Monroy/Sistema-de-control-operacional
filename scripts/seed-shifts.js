const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
    const shifts = [
        { code: 'A', name: 'Turno A', cycle_days: 10 },
        { code: 'B', name: 'Turno B', cycle_days: 10 },
    ];

    for (const shift of shifts) {
        const existing = await prisma.shiftGroup.findUnique({
            where: { code: shift.code },
        });

        if (!existing) {
            console.log(`Creating shift: ${shift.name}`);
            await prisma.shiftGroup.create({
                data: shift,
            });
        } else {
            console.log(`Shift already exists: ${shift.name}`);
        }
    }
}

main()
    .catch((e) => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
