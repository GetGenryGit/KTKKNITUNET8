namespace KTKGuest.Web.Services;

public class DictionariesService(ICollectivesRepositoty collectivesRepositoty,
    ITeachersRepository teachersRepository, IClassroomsRepository classroomsRepository,
    ISubjectsRepository subjectsRepository) : IDictionariesService
{
    private readonly ICollectivesRepositoty _collectivesRepositoty = collectivesRepositoty;
    private readonly ITeachersRepository _teachersRepository = teachersRepository;
    private readonly IClassroomsRepository _classroomsRepository = classroomsRepository;
    private readonly ISubjectsRepository _subjectsRepository = subjectsRepository;

    public async Task<bool> Add(DictionaryType type, List<string> list)
    {
        int countRows;

        switch (type) 
        {
            case DictionaryType.Collectives:
                countRows = await _collectivesRepositoty.AddCollectivesAsync(list);
                break;
            case DictionaryType.Teachers:
                countRows = await _teachersRepository.AddTeachersAsync(list); 
                break;
            case DictionaryType.Classrooms:
                countRows = await _classroomsRepository.AddClassroomsAsync(list);
                break;
            case DictionaryType.Subjects:
                countRows = await _subjectsRepository.AddSubjectsAsync(list);
                break;
            default:
                throw new ArgumentException(nameof(type));
        }

        return countRows > 0;
    }
    public async Task<List<string>> GetActive(DictionaryType type)
    {
        switch (type)
        {
            case DictionaryType.Collectives:
                return await _collectivesRepositoty.GetActiveCollectivesAsync();
            case DictionaryType.Teachers:
                return await _teachersRepository.GetActiveTeachersAsync();
            case DictionaryType.Classrooms:
                return await _classroomsRepository.GetActiveClassroomsAsync();
            case DictionaryType.Subjects:
                return await _subjectsRepository.GetActiveSubjectsAsync();
            default:
                throw new ArgumentException(nameof(type));
        }
    }
    public async Task<List<DictionaryItem>> GetAll(DictionaryType type)
    {
        switch (type)
        {
            case DictionaryType.Collectives:
                return await _collectivesRepositoty.GetAllCollectivesAsync();
            case DictionaryType.Teachers:
                return await _teachersRepository.GetAllTeachersAsync();
            case DictionaryType.Classrooms:
                return await _classroomsRepository.GetAllClassroomsAsync();
            case DictionaryType.Subjects:
                return await _subjectsRepository.GetAllSubjectsAsync();
            default:
                throw new ArgumentException(nameof(type));
        }
    }
}
