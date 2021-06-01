@extends('layout/main')

@section('title', 'Mahasiswa Page')

@section('container')
<div class="container">
    <div class="row">
        <div class="col-10">
            <h1 class="mt-3">Selamat Datang di Halaman Mahasiswa !</h1>
            <table class="table">
                <thead class="table-dark">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">NIK</th>
                    <th scope="col">Nama</th>
                    <th scope="col">Jenis Kelamin</th>
                    <th scope="col">Tanggal Lahir</th>
                    <th scope="col">Aksi</th>
                </tr>
                </thead>
                <tbody>
                @foreach($mahasiswa as $mhs)
                <tr>
                    <th scope="row">{{ $loop->iteration }}</th>
                    <td>{{ $mhs->nik }}</td>
                    <td>{{ $mhs->nama }}</td>
                    <td>{{ $mhs->jenis_kelamin }}</td>
                    <td>{{ $mhs->tanggal_lahir }}</td>
                    <td>
                        <a href="" class="badge bg-success">edit</a>
                        <form action="/mahasiswa/{{ $mhs->nik }}" method="post" class="d-inline">
                            @method('delete')
                            @csrf
                            <button type="submit" class="btn btn-danger">delete</button>
                        </form>
                    </td>
                </tr>
                @endforeach
                </tbody>
            </table>
        </div>
    </div>
</div>
@endsection