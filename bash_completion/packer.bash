# Generates completion reply, appending a space to possible completion words,
# if necessary.
# It accepts 2 arguments though the second is optional:
# 1: List of possible completion words.
# 2: Generate possible completion matches for this word (optional).
__packercomp ()
{
    local cur_="${2-$cur}"

    case "$cur_" in
    -*=)
        ;;
    *)
        local c i=0 IFS=$' \t\n'
        for c in $1; do
            if [[ $c == "$cur_"* ]]; then
                case $c in
                    -*=*|*.) ;;
                    *) c="$c " ;;
                esac
                COMPREPLY[i++]="$c"
            fi
        done
        ;;
    esac
}

# Generates completion reply for template files in cwd.
__packercomp_template_file ()
{
    local IFS=$'\n'

    COMPREPLY=($(compgen -S " " -A file -X '!*.json' -- "${cur}"))
}

# Generates completion for the build command.
__packer_build ()
{
    local builders="
        amazon-ebs amazon-instance amazon-chroot digitalocean docker
        googlecompute openstack parallels-iso parallels-pvm qemu
        virtualbox-iso virtualbox-ovf vmware-iso vmware-vmx"

    case "$cur" in
        -color=*)
            __packercomp "false true" "${cur##-color=}"
            return
            ;;
        -parallel=*)
            __packercomp "false true" "${cur##-parallel=}"
            return
            ;;
        -except=*)
            __packercomp "$builders" "${cur##-except=}"
            return
            ;;
        -only=*)
            __packercomp "$builders" "${cur##-only=}"
            return
            ;;
        -on-error=*)
            __packercomp "cleanup abort ask" "${cur##-on-error=}"
            return
            ;;
        -*)
            __packercomp "-color= -debug -force -machine-readable -except= -only= -on-error= -parallel= -var -var-file="
            return
            ;;
        *)
    esac

    __packercomp_template_file
}

# Generates completion for the fix command.
__packer_fix ()
{
    case "$cur" in
        -validate=*)
            __packercomp "true false" "$#{cur##-validate=}"
            return
            ;;
        -*)
            __packercomp "-validate="
            return
            ;;
        *)
    esac

    __packercomp_template_file
}

# Generates completion for the inspect command.
__packer_inspect ()
{
    case "$cur" in
        -*)
            __packercomp "-machine-readable"
            return
            ;;
        *)
    esac

    __packercomp_template_file
}

# Generates completion for the push command.
__packer_push ()
{
    case "$cur" in
        -*)
            __packercomp "-name= -token= -var -var-file="
            return
            ;;
        *)
    esac

    __packercomp_template_file
}

# Generates completion for the validate command.
__packer_validate ()
{
     case "$cur" in
        -*)
            __packercomp "-syntax-only -execpt= -only= -var -var-file="
            return
            ;;
        *)
    esac

   __packercomp_template_file
}

# Main function for packer completion.
#
# Searches for a command in $COMP_WORDS. If one is found
# the appropriate function from above is called, if not
# completion for global options is done.
_packer_completion ()
{
    cur=${COMP_WORDS[COMP_CWORD]}
    # Words containing an equal sign get split into tokens in bash > 4, which
    # doesn't come in handy here.
    # This is handled here. bash < 4 does not split.
    declare -f _get_comp_words_by_ref >/dev/null && _get_comp_words_by_ref -n = cur

    COMPREPLY=()
    local i c=1 command

    while [ $c -lt $COMP_CWORD ]; do
        i="${COMP_WORDS[c]}"
        case "$i" in
            -*) ;;
            *) command="$i"; break ;;
        esac
        ((c++))
    done

    if [ -z $command ]; then
        case "$cur" in
            '-'*)
                __packercomp "-machine-readable --help"
                ;;
            *)
                __packercomp "build fix inspect push validate version"
                ;;
        esac
        return
    fi

    local completion_func="__packer_${command}"
    declare -f $completion_func >/dev/null && $completion_func
}

complete -o nospace -F _packer_completion packer