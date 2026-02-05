import { NextResponse } from 'next/server';
import prisma from '@/lib/prisma';

// GET /api/workers - List all workers
export async function GET() {
    try {
        const workers = await prisma.worker.findMany({
            orderBy: { full_name: 'asc' },
        });
        return NextResponse.json(workers);
    } catch (error) {
        console.error('Error fetching workers:', error);
        return NextResponse.json(
            { error: 'Error fetching workers' },
            { status: 500 }
        );
    }
}

// POST /api/workers - Create a new worker
export async function POST(request: Request) {
    try {
        const body = await request.json();
        const { rut, full_name, shift_group_id } = body;

        if (!rut || !full_name) {
            return NextResponse.json(
                { error: 'RUT and Name are required' },
                { status: 400 }
            );
        }

        // Determine initial shift group if provided
        // Note: In a real flow, we might want to handle this transactionally with assignments
        const worker = await prisma.worker.create({
            data: {
                rut,
                full_name,
                // If we had a direct relation for current shift, we'd set it here, 
                // but per schema, it's in assignments. For MVP simplified creation:
            },
        });

        return NextResponse.json(worker, { status: 201 });
    } catch (error) {
        console.error('Error creating worker:', error);
        return NextResponse.json(
            { error: 'Error creating worker' },
            { status: 500 }
        );
    }
}
