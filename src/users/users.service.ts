import { Injectable, ConflictException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { User } from './entities/user.entity';
import { RegisterDto } from './dto/register.dto';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private usersRepository: Repository<User>,
  ) {}

  async create(registerDto: RegisterDto): Promise<Omit<User, 'password' | 'refreshToken'>> {
    const existingUser = await this.usersRepository.findOne({
      where: { username: registerDto.username },
    });

    if (existingUser) {
      throw new ConflictException('Username already exists');
    }

    const hashedPassword = await bcrypt.hash(registerDto.password, 10);

    const user = this.usersRepository.create({
      username: registerDto.username,
      password: hashedPassword,
    });

    const savedUser = await this.usersRepository.save(user);
    const { password: _password, refreshToken: _refreshToken, ...result } = savedUser;
    return result;
  }

  async findOne(username: string): Promise<User | null> {
    return this.usersRepository.findOne({ where: { username } });
  }

  async findById(id: number): Promise<User | null> {
    return this.usersRepository.findOne({ where: { id } });
  }

  async updateRefreshToken(userId: number, refreshToken: string): Promise<void> {
    await this.usersRepository.update(userId, { refreshToken });
  }

  async removeRefreshToken(userId: number): Promise<void> {
    await this.usersRepository.update(userId, { refreshToken: null });
  }

  async validatePassword(password: string, hashedPassword: string): Promise<boolean> {
    return bcrypt.compare(password, hashedPassword);
  }
}
