/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   terminal_draw1.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: odrinkwa <odrinkwa@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/02/29 18:53:04 by odrinkwa          #+#    #+#             */
/*   Updated: 2020/02/29 18:53:05 by odrinkwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

void		td_setcolor(int color)
{
	ft_printf("\033[%dm", color);
}

void		td_reset_color(void)
{
	ft_printf("\033[0m");
}

void		td_home(void)
{
	ft_printf("\033[H");
}

void		td_goto(int x, int y)
{
	ft_printf("\033[%d;%dH", y, x);
}

void		td_gotoinline(int line)
{
	ft_printf("\033[%d`", line);
}
