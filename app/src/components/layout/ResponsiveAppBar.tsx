import * as React from 'react';
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import Toolbar from '@mui/material/Toolbar';
import IconButton from '@mui/material/IconButton';
import Typography from '@mui/material/Typography';
import Menu from '@mui/material/Menu';
import MenuIcon from '@mui/icons-material/Menu';
import Container from '@mui/material/Container';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import Tooltip from '@mui/material/Tooltip';
import MenuItem from '@mui/material/MenuItem';
import AdbIcon from '@mui/icons-material/Adb';
import { Link, NavLink } from 'react-router-dom';
import { useAppDispatch } from '../../features/hooks';
import authActions, { initialAuthState } from '../../features/authData/authSlice';
import { useSelector } from 'react-redux';
import { RootState } from '../../features/store';
import { useEffect } from 'react';

const pages = [''];
const settings = ['Profile', 'Dashboard', 'Logout'];

const ResponsiveAppBar = () => {
    const authSlice = useSelector((state: RootState) => state.authSlice);

    let photoUrl;
    if (authSlice.photoUrl) {
        photoUrl = authSlice.photoUrl;
    }

    const [anchorElNav, setAnchorElNav] = React.useState<null | HTMLElement>(null);
    const [anchorElUser, setAnchorElUser] = React.useState<null | HTMLElement>(null);
    const dispatch = useAppDispatch();

    const handleOpenNavMenu = (event: React.MouseEvent<HTMLElement>) => {
        setAnchorElNav(event.currentTarget);
    };
    const handleOpenUserMenu = (event: React.MouseEvent<HTMLElement>) => {
        setAnchorElUser(event.currentTarget);
    };

    const handleCloseNavMenu = () => {
        setAnchorElNav(null);
    };

    const handleCloseUserMenu = () => {
        setAnchorElUser(null);
    };

    return (
        <AppBar position="static" sx={{ backgroundColor: 'rgb(100, 21, 255)' }}>
            <Container maxWidth="md">
                <Toolbar disableGutters>
                    {/*DESKTOP MODE*/}
                    {/*<AdbIcon sx={{ display: { xs: 'none', md: 'flex' }, mr: 1 }} />*/}
                    <Typography
                        variant="h6"
                        noWrap
                        // component="a"
                        // href="/"
                        sx={{
                            mr: 2,
                            display: { xs: 'none', md: 'flex' },
                            fontFamily: 'inter',
                            fontWeight: 900,
                            // letterSpacing: '.3rem',
                            letterSpacing: '.1rem',
                            color: 'inherit',
                            textDecoration: 'none',
                        }}
                    >
                        <Link to="/" style={{ textDecoration: 'none', color: 'inherit' }}>
                            Valvio
                        </Link>
                    </Typography>

                    <Box sx={{ flexGrow: 1, display: { xs: 'flex', md: 'none' } }}>
                        <IconButton
                            size="large"
                            aria-label="account of current user"
                            aria-controls="menu-appbar"
                            aria-haspopup="true"
                            onClick={handleOpenNavMenu}
                            color="inherit"
                        >
                            <MenuIcon />
                        </IconButton>
                        <Menu
                            id="menu-appbar"
                            anchorEl={anchorElNav}
                            anchorOrigin={{
                                vertical: 'bottom',
                                horizontal: 'left',
                            }}
                            keepMounted
                            transformOrigin={{
                                vertical: 'top',
                                horizontal: 'left',
                            }}
                            open={Boolean(anchorElNav)}
                            onClose={handleCloseNavMenu}
                            sx={{
                                display: { xs: 'block', md: 'none' },
                            }}
                        >
                            {pages.map((page) => (
                                <MenuItem key={page} onClick={handleCloseNavMenu}>
                                    <Typography textAlign="center">{page}</Typography>
                                </MenuItem>
                            ))}
                        </Menu>
                    </Box>
                    {/*Mobile MODE*/}
                    {/*<AdbIcon sx={{ display: { xs: 'flex', md: 'none' }, mr: 1 }} />*/}
                    <Typography
                        variant="h5"
                        noWrap
                        // component="a"
                        // href=""
                        sx={{
                            mr: 2,
                            display: { xs: 'flex', md: 'none' },
                            flexGrow: 1,
                            fontFamily: 'inter',
                            fontWeight: 900,
                            letterSpacing: '.1rem',
                            color: 'inherit',
                            textDecoration: 'none',
                        }}
                    >
                        <Link to="/" style={{ textDecoration: 'none', color: 'inherit' }}>
                            Valvio
                        </Link>
                    </Typography>
                    <Box sx={{ flexGrow: 1, display: { xs: 'none', md: 'flex' } }}>
                        {pages.map((page) => (
                            <Button
                                key={page}
                                onClick={handleCloseNavMenu}
                                sx={{ my: 2, color: 'white', display: 'block' }}
                            >
                                {page}
                            </Button>
                        ))}
                    </Box>

                    <Box sx={{ flexGrow: 0 }}>
                        {authSlice.isAuthenticated && (
                            <>
                                <Tooltip title="Open settings">
                                    <IconButton onClick={handleOpenUserMenu} sx={{ p: 0 }}>
                                        <Avatar alt="user_avatar" src={authSlice.photoUrl || ''} />
                                    </IconButton>
                                </Tooltip>
                                <Menu
                                    sx={{ mt: '45px' }}
                                    id="menu-appbar"
                                    anchorEl={anchorElUser}
                                    anchorOrigin={{
                                        vertical: 'top',
                                        horizontal: 'right',
                                    }}
                                    keepMounted
                                    transformOrigin={{
                                        vertical: 'top',
                                        horizontal: 'right',
                                    }}
                                    open={Boolean(anchorElUser)}
                                    onClose={handleCloseUserMenu}
                                >
                                    {/*{settings.map((setting) => (*/}
                                    {/*    <MenuItem key={setting} onClick={handleCloseUserMenu}>*/}
                                    {/*        <Typography textAlign="center">{setting}</Typography>*/}
                                    {/*    </MenuItem>*/}
                                    {/*))}*/}

                                    <MenuItem key={0}>
                                        <Link to="/profile" style={{ textDecoration: 'none', color: 'inherit' }}>
                                            <Typography textAlign="center">Profile</Typography>
                                        </Link>
                                    </MenuItem>

                                    <MenuItem key={1}>
                                        <Link to="/dashboard" style={{ textDecoration: 'none', color: 'inherit' }}>
                                            <Typography textAlign="center">Dashboard</Typography>
                                        </Link>
                                    </MenuItem>

                                    {/*<MenuItem key={2} onClick={()=>{dispatch(authActions.logout(initialAuthState))}}>*/}
                                    {/*    <Link to="/login" style={{textDecoration: 'none', color: 'inherit'}}>*/}
                                    {/*        <Typography textAlign="center" >Logout</Typography>*/}
                                    {/*    </Link>*/}
                                    {/*</MenuItem>*/}
                                </Menu>
                            </>
                        )}
                    </Box>
                </Toolbar>
            </Container>
        </AppBar>
    );
};
export default ResponsiveAppBar;
