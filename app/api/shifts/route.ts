import { NextResponse } from 'next/server';
import prisma from '@/lib/prisma';

// GET /api/shifts - List all shift groups
export async function GET() {
    try {
        const shifts = await prisma.shiftGroup.findMany({
            orderBy: { code: 'asc' },
        });
        return NextResponse.json(shifts);
    } catch (error) {
        console.error('Error fetching shifts:', error);
        return NextResponse.json(
            { error: 'Error fetching shifts' },
            { status: 500 }
        );
    }
}

// POST /api/shifts - Create a new shift group
export async function POST(request: Request) {
    try {
        const body = await request.json();
        const { code, name, cycle_days } = body;

        if (!code || !name) {
            return NextResponse.json(
                { error: 'Code and Name are required' },
                { status: 400 }
            );
        }

        const shift = await prisma.shiftGroup.create({
            data: {
                code,
                name,
                cycle_days: cycle_days || 10,
            },
        });

        return NextResponse.json(shift, { status: 201 });
    } catch (error) {
        console.error('Error creating shift:', error);
        // Handle unique constraint violation
        if (error instanceof Error && error.message.includes('Unique constraint')) {
            return NextResponse.json(
                { error: 'Shift code already exists' },
                { status: 409 }
            );
        }
        return NextResponse.json(
            { error: 'Error creating shift' },
            { status: 500 }
        );
    }
}
